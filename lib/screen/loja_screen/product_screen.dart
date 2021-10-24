import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/screen/loja_screen/widgets/photo_tab.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/loja_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatelessWidget {
  final TextEditingController cepController =
      TextEditingController(text: '35240-000');
  ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VisibilityWidget(
          nivel: VisibilityWidget.admin,
          widget: SizedBox(height: 8),
        ),
        const VisibilityWidget(
          nivel: VisibilityWidget.admin,
          text: 'Editar produto',
          page: 10,
        ),
        const SizedBox(height: 20),
        context.read<LojaController>().currentProduc!.images!.isNotEmpty
            ? const PhotoTab()
            : Container(
                color: Colors.grey[200],
                width: 500,
                height: 500,
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                ),
              ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Consumer<LojaController>(
            builder: (context, productManager, __) {
              return Column(
                children: [
                  Text(
                    productManager.currentProduc!.title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 125, 141),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Descrição:',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    productManager.currentProduc!.descripion,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  // const Divider(),
                  // Row(
                  //   children: [
                  //     const Text(
                  //       'Calcule o frete colocando o seu CEP:',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     const Spacer(),
                  //     if (productManager.currentCep != null)
                  //       Row(
                  //         children: [
                  //           const Text(
                  //             'Frete: ',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color.fromARGB(255, 4, 125, 141),
                  //             ),
                  //           ),
                  //           Text(
                  //             productManager.currentCep! + '  ',
                  //             style: const TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: const Color.fromARGB(255, 4, 125, 141),
                  //       ),
                  //       onPressed: () async {
                  //         // if (Form.of(context)!.validate()) {
                  //         //   final dio = Dio();
                  //         //   const isWeb = true;
                  //         //   bool useSSL = false;

                  //         //   // Vai definir se a base do endpoint deverá usar HTTPS ou apenas HTTP
                  //         //   final baseEndpoint =
                  //         //       // ignore: dead_code
                  //         //       'http${useSSL ? 's' : ''}://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx';
                  //         //   final endpoint =
                  //         //       '${isWeb ? "https://cors-anywhere.herokuapp.com/" : ""}$baseEndpoint';
                  //         //   try {
                  //         //     var resp = await dio.get(
                  //         //         '$endpoint/CalcPrecoPrazo',
                  //         //         queryParameters: {
                  //         //           'nCdEmpresa': '08082650',
                  //         //           'sDsSenha': '564321',
                  //         //           'nCdServico': '04014',
                  //         //           // 'nCdServico': servicosList.join(','),
                  //         //           'sCepOrigem':
                  //         //               SgUtils.formataCEP('26285060'),
                  //         //           // 'sCepOrigem': SgUtils.formataCEP(cepOrigem),
                  //         //           'sCepDestino': SgUtils.formataCEP(
                  //         //               cepController.text.replaceAll('-', '')),
                  //         //           'nVlPeso': 1.toString(),
                  //         //           // 'nVlPeso': valorPeso.toString(),
                  //         //           'nCdFormato': SgUtils.codFormato(
                  //         //               FormatoEncomenda.caixa),
                  //         //           'nVlComprimento': 20.toString(),
                  //         //           'nVlAltura': 20.toString(),
                  //         //           'nVlLargura': 20.toString(),
                  //         //           'nVlDiametro': 0.toString(),
                  //         //           // 'sCdMaoPropria': maosPropria ? 'S' : 'N',
                  //         //           'sCdMaoPropria': 'N',
                  //         //           'nVlValorDeclarado': 0.toString(),
                  //         //           'sCdAvisoRecebimento': 'N',
                  //         //           'StrRetorno': 'xml',
                  //         //           'nIndicaCalculo': '3'
                  //         //         });
                  //         //     print('cu');
                  //         //     print(resp.data);
                  //         //   } catch (e) {
                  //         //     print(e);
                  //         //   }

                  //         try {
                  //           var sigep =
                  //               Sigepweb(contrato: SigepContrato.semContrato());

                  //           var calcPrecoPrazo = await sigep.calcPrecoPrazo(
                  //             cepOrigem: '26285060',
                  //             cepDestino:
                  //                 cepController.text.replaceAll('-', ''),
                  //             valorPeso: 1,
                  //           );
                  //           print('passastes');

                  //           calcPrecoPrazo.forEach((element) {
                  //             print('tá cá' + element.valor.toString());
                  //           });

                  //           // Isso vai retornar uma lista com os
                  //           // resultados do calculo
                  //           for (var item in calcPrecoPrazo) {
                  //             if (item.nome == 'PAC') {
                  //               productManager.setCurrentCep =
                  //                   'R\$${item.valor.toString()}';
                  //             }
                  //             print("${item.nome}: R\$ ${item.valor}");
                  //           }
                  //         } catch (e) {
                  //           print('entrou erro');
                  //           print(e);
                  //           productManager.setCurrentCep =
                  //               'CEP digitado é inválido';
                  //         }
                  //         // context.read<LojaController>().consultarCep(
                  //         //       cepController.text.replaceAll('-', ''),
                  //         //       productManager.currentProduc!,
                  //         //     );
                  //         // }
                  //       },
                  //       child: const Text('Calcular frete'),
                  //     ),
                  //   ],
                  // ),
                  // TextFormField(
                  //   controller: cepController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'CEP',
                  //     hintText: 'Digite seu CEP',
                  //   ),
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.digitsOnly,
                  //     CepInputFormatter(),
                  //   ],
                  //   validator: (cep) {
                  //     if (cep == null || cep.isEmpty) {
                  //       return 'Campo obrigatório';
                  //     } else if (cep.length != 9 && cep.length != 10) {
                  //       return 'CEP Inválido';
                  //     }
                  //     return null;
                  //   },
                  //   keyboardType: TextInputType.number,
                  // ),
                  // const SizedBox(height: 8),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        'R\$ ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 4, 125, 141),
                        ),
                      ),
                      Text(
                        productManager.currentProduc!.price,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            '  + Frete de ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 125, 141),
                            ),
                          ),
                          Text(
                            productManager.currentProduc!.frete,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 4, 125, 141),
                        ),
                        onPressed: () async {
                          String nomeProduto =
                              productManager.currentProduc!.title;
                          String precoProduto =
                              productManager.currentProduc!.price;
                          String link = 'https://api.whatsapp.com/send?phone='
                              '5521973630631&text=Ol%C3%A1!%20Estou%20interessado%'
                              '20no%20item%20que%20vi%20na%20loja.%20O%20$nomeProduto'
                              '%20que%20custa%20$precoProduto%20%C3%A9%20o%20produto%20que%'
                              '20estou%20interessado.';

                          if (await canLaunch(link)) launch(link);
                        },
                        child: const Text('Finalizar Compra'),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
