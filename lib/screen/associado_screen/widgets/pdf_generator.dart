import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class BuildPdfWidget extends StatelessWidget {
  final Uint8List image;
  final String cpf;
  final String quantia;
  final String dia;
  final String mes;
  final String ano;
  String via = '';
  String reciboRS = '00944';
  BuildPdfWidget(
    this.image, {
    required this.cpf,
    required this.quantia,
    required this.dia,
    required this.mes,
    required this.ano,
    required this.via,
  });

  @override
  Widget build(Context context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'FEDERAÇÃO DE XADREZ DO ESTADO DO RJ\n'
                      'FEXERJ - CNPJ: 29.511.789/0001-27',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'http://www.fexerj.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const PdfColor(0.2, 0.6, 1),
                      ),
                    ),
                  ],
                ),
                Image(MemoryImage(image), fit: BoxFit.fitHeight, width: 75),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'RECIBO R\$',
                      style: TextStyle(
                        // fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '1° Via',
                      style: TextStyle(
                        // fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: const PdfColor(0.7, 0.7, 0.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        reciboRS,
                        style: TextStyle(
                          // fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      via,
                      style: TextStyle(
                        // fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'RECEBI do Sr.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4)
                    ],
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  //CPF
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'CPF:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4)
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0),
                              ),
                            ),
                            child: Text(
                              cpf,
                              style: const TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //quantia de reais
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '  , a quantia de ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4)
                          ],
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              //corresponde ao pagamento de
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Correspondente ao pagamento de',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4)
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2.0),
                        ),
                      ),
                      child: Text(
                        dia,
                        style: const TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  //lugar //mes //de 2021
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Rio de Janeiro, ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4)
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0),
                              ),
                            ),
                            child: Text(
                              dia,
                              style: const TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '  de',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4)
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0),
                              ),
                            ),
                            child: Text(
                              mes,
                              style: const TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '  de',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4)
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 2.0),
                              ),
                            ),
                            child: Text(
                              ano,
                              style: const TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 64),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LUIZ ANTONIO BARDARIO MANZI:00855277777',
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Assinado de forma digital por '
                      'LUIZ ANTONIO BARDARIO MANZI:00855277777\n'
                      'Dados: 2021.09.28  11:50:02 - 03\'00\'',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'FEDERAÇÃO DE XADREZ DO ESTADO DO RJ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
