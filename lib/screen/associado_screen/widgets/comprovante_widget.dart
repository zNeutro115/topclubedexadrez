import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/models/comprovante_section_model.dart';
import 'package:topxadrez/screen/associado_screen/widgets/build_info_widget.dart';

class ComprovanteWidget extends StatelessWidget {
  final String recebiDoSr;
  final String cpf;
  final String quantia;
  final String dia;
  final String mes;
  final String ano;
  final String via;
  final List<ComprovanteSection> compras;

  const ComprovanteWidget({
    Key? key,
    required this.recebiDoSr,
    required this.cpf,
    required this.quantia,
    required this.dia,
    required this.mes,
    required this.ano,
    required this.via,
    required this.compras,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 4, 125, 141),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assets/topclube.png',
                  width: 75,
                  fit: BoxFit.fitHeight,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'TOP CLUBE DE XADREZ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 155),
                        Text(
                          'CNPJ: 34.724.857/0001-76\n'
                          'TEL: (21) 9 8464-7493',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'RUA GOVERNADOR ROBERTO SILVEIRA 540, LOJA 354 -'
                      'MOQUETÁ - NOVA IGUAÇU-RJ - 26285 260',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 2, color: Color.fromARGB(255, 4, 125, 141)),
          BuildInfoWidget(
            'CONTRIBUINTE:',
            recebiDoSr,
            width: 32,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: BuildInfoWidget(
                  'CPF:',
                  cpf,
                ),
              ),
              Expanded(
                flex: 2,
                child: BuildInfoWidget(
                  ', CÓDIGO:',
                  via,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BuildInfoWidget(
                  'Nova Iguaçu, dia',
                  dia,
                ),
              ),
              Expanded(
                child: BuildInfoWidget(
                  '  de',
                  mes,
                ),
              ),
              Expanded(
                child: BuildInfoWidget(
                  '  de',
                  ano,
                ),
              ),
              const SizedBox(width: 64),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Descrição do Produto:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ...compras
              .map((e) => Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            e.nome,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(flex: 5),
                          Text(
                            'Unidade: R\$' + e.total,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Quantidade: ' + e.quantidade,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Total: R\$' + e.total,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
              .toList(),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'UNIDOS SOMOS MAIS FORTES!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Text(
                'VALOR TOTAL:   ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                quantia,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 220),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black),
                  ),
                  color: Colors.white,
                ),
              ),
              const Text(
                'VISTO DO ATENDENTE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
