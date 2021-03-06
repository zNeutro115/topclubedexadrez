// ignore_for_file: avoid_print

library sigepweb;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:topxadrez/controllers/correio/src/constants.dart';
import 'package:topxadrez/controllers/correio/src/exceptions/sigepweb_runtime_error.dart';
import 'package:topxadrez/controllers/correio/src/models/calc_preco_prazo_item_model.dart';
import 'package:topxadrez/controllers/correio/src/models/consulta_cep_model.dart';
import 'package:topxadrez/controllers/correio/src/models/contrato.dart';
import 'package:topxadrez/controllers/correio/src/utils.dart';
import 'package:xml2json/xml2json.dart';

/// A classe principal
class Sigepweb {
  ///
  /// Endpoint para caso de ambiente de testes
  final _homEndpoint =
      'https://apphom.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  ///
  /// Endpoint para caso de ambiente de producao.
  ///
  /// Este endpoint será usado quando [isDebug] for falso e nesse caso é necessário
  /// informar o [contrato]
  final _prodEndpoint =
      'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl';

  final bool useSSL;
  final bool isDebug;
  final dio = Dio();

  SigepContrato? contrato;

  /// Construtor padrao.
  /// Voce pode iniciar esta classe passando um [contrato] ou informando [isDebug]
  /// como true que usara entao o ambiente de homologacao para testes.
  ///
  /// Quando [isDebug] for informado como true então o contrato sera sobrescrito
  /// para homolog.
  Sigepweb({
    this.contrato,
    this.isDebug = false,
    this.useSSL = false,
  }) {
    if (contrato == null && !isDebug) {
      throw const SigepwebRuntimeError(
          'Obrigatório informar o contrato ou estar em modo debug');
    }

    if (isDebug) {
      contrato = SigepContrato.homolog();
    }
  }

  /// Efetua os calculos de preco e prazo para uma encomenda.
  /// Resulta numa lista de [CalcPrecoPrazoItemModel].
  ///
  /// [servicosList] é onde você informa quais os servicos que quer cotacao.
  /// Encontre a lista padrao de servicos disponíveis em [ServicosPostagem].
  Future<List<CalcPrecoPrazoItemModel>> calcPrecoPrazo({
    List<String> servicosList = const [
      ServicosPostagem.sedexAVista_04014,
      ServicosPostagem.pacAVista_04510,
    ],
    required String cepOrigem,
    required String cepDestino,
    double valorPeso = .5,
    FormatoEncomenda formatoEncomenda = FormatoEncomenda.caixa,
    int comprimento = 20,
    int altura = 20,
    int largura = 20,
    int diametro = 0,
    bool maosPropria = false,
    double valorDeclarado = 0.0,
    bool avisoRecebimento = false,
  }) async {
    // If it is not Android nor iOS so we assume that it is Web.
    // It is made that way to avoid dependency of Flutter on this package,
    // do you know a better way to do that? Tell us...
    const isWeb = true;

    // Vai definir se a base do endpoint deverá usar HTTPS ou apenas HTTP
    final baseEndpoint =
        'http${useSSL ? 's' : ''}://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';

    //
    // O Endpoint para calculo de preco e prazo eh o unico diferente
    // (ate agora)
    final endpoint =
        '${isWeb ? "https://cors-anywhere.herokuapp.com/" : ""}$baseEndpoint';

    var result = <CalcPrecoPrazoItemModel>[];

    try {
      if (servicosList.isEmpty) {
        throw const SigepwebRuntimeError(
            "Parâmetro 'servicosList' obrigatório");
      }

      // Efetiva a consulta
      var resp = await dio.get('$endpoint/CalcPrecoPrazo', queryParameters: {
        'nCdEmpresa':
            contrato!.codAdmin!.isEmpty ? '08082650' : contrato!.codAdmin,
        'sDsSenha': contrato!.senha!.isEmpty ? '564321' : contrato!.senha,
        'nCdServico': servicosList.join(','),
        'sCepOrigem': SgUtils.formataCEP(cepOrigem),
        'sCepDestino': SgUtils.formataCEP(cepDestino),
        'nVlPeso': valorPeso.toString(),
        'nCdFormato': SgUtils.codFormato(formatoEncomenda),
        'nVlComprimento': comprimento.toString(),
        'nVlAltura': altura.toString(),
        'nVlLargura': largura.toString(),
        'nVlDiametro': diametro.toString(),
        'sCdMaoPropria': maosPropria ? 'S' : 'N',
        'nVlValorDeclarado': valorDeclarado.toString(),
        'sCdAvisoRecebimento': avisoRecebimento ? 'S' : 'N',
        'StrRetorno': 'xml',
        'nIndicaCalculo': '3'
      });

      // Valida resposta
      if (resp.statusCode != 200 || resp.data.isEmpty) {
        throw const SigepwebRuntimeError();
      }

      // Captura o resultado e faz o parse
      // de XML para JSON
      //
      // Parker: https://github.com/shamblett/xml2json/blob/master/doc/Transforming Details.md
      var xml2json = Xml2Json();
      xml2json.parse(resp.data);
      Map<String, dynamic> apiResult = json.decode(xml2json.toParker());

      // Verifica se a estrutura do retorno veio como esperado
      if (apiResult['cResultado'] == null ||
          apiResult['cResultado']['Servicos'] == null ||
          apiResult['cResultado']['Servicos']['cServico'] == null) {
        throw const SigepwebRuntimeError(
          'Xml result format isn\'t with expected format',
        );
      }

      // Guarda o retorno em uma variavel para facilitar
      var cServico = apiResult['cResultado']['Servicos']['cServico'];

      // Verifica se houve retorno com erro
      if (cServico is Map &&
          cServico['Erro'] != null &&
          cServico['Erro'] != '0') {
        throw SigepwebRuntimeError(cServico['MsgErro']);
      }

      // Quando a resposta tem apenas um item entao ele vira como Map
      // e nos temos que colocar esse map numa lista, por outro lado
      // pode acontecer de vir diretamente como lista de Map
      List cServicoList = (cServico is Map) ? [cServico] : cServico;

      // Nao houve erro entao cria uma model com cada resultado da lista de
      // retorno
      for (Map<String, dynamic> i in cServicoList) {
        result.add(CalcPrecoPrazoItemModel.fromJson(i));
      }
    } on Exception catch (e, st) {
      //
      // Se entrar nesta exception entao o problema nao foi
      // necessariamente no package, mas nas suas dependencias
      // como o Dio (talvez conexao de fato), Xml2Json, etc...
      //
      if (isDebug) {
        print(e);
        print(st);
      }

      throw SigepwebRuntimeError(
          'Erro interno do package. Por favor considere abrir uma questão em https://github.com/marcobraghim/sigepweb/issues\nMensagem da exception foi: ${e.toString()}');
    }
    return result;
  }

  /// A partir do [cep] este metodo busca na API
  /// o resultado que sera embutido na model [ConsultaCepModel].
  /// Poderá disparar [SigepwebRuntimeError] caso o CEP seja
  /// inválido.
  Future<ConsultaCepModel> consultaCEP(String cep) async {
    var endpoint = _getEndpoint();

    try {
      //
      // No link abaixo você pode entender como fazer uma consulta SOAP por
      // uma ext do navegador. A logica aqui eh a mesma
      // https://medium.com/@markos12/consumindo-o-webservice-dos-correios-soap-via-extensão-do-1b087bf290fb

      var envelope =
          '''
        <soapenv:Envelope
          xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
          xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/">
          <soapenv:Header/>
          <soapenv:Body>
            <cli:consultaCEP>
              <cep>${SgUtils.formataCEP(cep)}</cep>
            </cli:consultaCEP>
          </soapenv:Body>
        </soapenv:Envelope>
      ''';

      // Efetiva a consulta
      var response = await http.post(
        Uri.parse(endpoint),
        // endpoint,
        //TODO: tem q fzr né...
        headers: {'Content-Type': 'text/xml; encoding=iso-8859-1'},
        body: envelope,
      );

      // valida resposta
      if (response.statusCode != 200 || response.body.isEmpty) {
        throw const SigepwebRuntimeError();
      }

      // Captura o resultado e faz o parse
      // de XML para JSON
      var xml2json = Xml2Json();
      xml2json.parse(response.body);
      Map<String, dynamic> apiResult = json.decode(xml2json.toGData());

      var soapBodyEnvelope =
          apiResult['soap\$Envelope']['soap\$Body']['ns2\$consultaCEPResponse'];

      if (soapBodyEnvelope['return'] == null) {
        return ConsultaCepModel();
      }

      return ConsultaCepModel.fromJson(soapBodyEnvelope['return']);
      //
      //
    } on Exception catch (e, st) {
      //
      // Se entrar nesta exception entao o problema nao foi
      // necessariamente no package, mas nas suas dependencias
      // como o Dio (talvez conexao de fato), Xml2Json, etc...
      //
      if (isDebug) {
        print(e);
        print(st);
      }

      throw SigepwebRuntimeError(
          'Erro interno do package. Por favor considere abrir uma questão em https://github.com/marcobraghim/sigepweb/issues\nMensagem da exception foi: ${e.toString()}');
    }
  }

  /// Determina a URL da API a partir do ambiente de execução atual
  /// usando [isDebug] como parâmetro
  String _getEndpoint() {
    return isDebug ? _homEndpoint : _prodEndpoint;
  }
}
