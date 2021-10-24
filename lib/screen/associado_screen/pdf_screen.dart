import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/models/comprovante_section_model.dart';
import 'package:topxadrez/screen/associado_screen/widgets/comprovante_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:topxadrez/screen/associado_screen/widgets/pdf_generator.dart';
import 'widgets/custom_textfield_comprovante.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key}) : super(key: key);

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String recebiDoSr = '';
  String cpf = '123456789-00';
  String quantia = '';
  String dia = DateTime.now().day.toString();
  String mes = DateTime.now().month.toString();
  String ano = DateTime.now().year.toString();
  String via = '00944';
  String nome = 'Tabuleiro';
  String quantidade = '3';
  String total = '40,00';
  final List<ComprovanteSection> compras = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Criação de Comprovante de Pagamento:',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 125, 141),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ComprovanteField(
                hint: 'CONTRIBUINTE:',
                onChanged: (text) {
                  setState(() {
                    recebiDoSr = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ComprovanteField(
                hint: 'CPF:',
                onChanged: (text) {
                  setState(() {
                    cpf = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ComprovanteField(
                hint: 'TOTAL:',
                onChanged: (text) {
                  setState(() {
                    quantia = text;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: ComprovanteField(
                hint: 'DIA:',
                initialValue: dia,
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (text) {
                  setState(() {
                    dia = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ComprovanteField(
                hint: 'MÊS:',
                initialValue: mes,
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (text) {
                  setState(() {
                    mes = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ComprovanteField(
                hint: 'ANO:',
                initialValue: ano,
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (text) {
                  setState(() {
                    ano = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: ComprovanteField(
                hint: 'CÓDIGO:',
                initialValue: via,
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (text) {
                  setState(() {
                    via = text;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 3),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 4, 125, 141),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              const Text(
                'Adicionar transação',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ComprovanteField(
                      hint: 'NOME:',
                      initialValue: nome,
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          nome = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ComprovanteField(
                      hint: 'QUANTIDADE:',
                      initialValue: quantidade,
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          quantidade = text;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: ComprovanteField(
                      hint: 'TOTAL DO ITEM:',
                      initialValue: total,
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (text) {
                        setState(() {
                          total = text;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    color: const Color.fromARGB(255, 4, 125, 141),
                    onPressed: () {
                      if (nome.isEmpty || quantidade.isEmpty || total.isEmpty) {
                        Utils.buildErrorMensage(context,
                            text: 'NÃO DEIXE NENHUM CAMPO VAZIO');
                        return;
                      }
                      setState(() {
                        compras
                            .add(ComprovanteSection(nome, quantidade, total));
                      });
                      setState(() {
                        nome = '';
                        quantidade = '';
                        total = '';
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ComprovanteWidget(
          recebiDoSr: recebiDoSr,
          ano: ano,
          cpf: cpf,
          dia: dia,
          mes: mes,
          quantia: quantia,
          via: via,
          compras: compras,
        ),
        const SizedBox(height: 12),
        const SizedBox(height: 8),
        VisibilityWidget(
          text: 'Criar Comprovante',
          onPressed: () async {
            final pdf = pw.Document();
            Future<Uint8List> _readImageData(String name) async {
              final data = await rootBundle.load('assets/$name');
              return data.buffer
                  .asUint8List(data.offsetInBytes, data.lengthInBytes);
            }

            Uint8List lista = await _readImageData('fexerj.png');
            pdf.addPage(
              pw.Page(
                pageFormat: const PdfPageFormat(750, 340, marginAll: 16),
                build: (pw.Context context) {
                  return pw.SizedBox(
                      child: BuildPdfWidget(
                    lista,
                    ano: ano,
                    cpf: cpf,
                    dia: dia,
                    mes: mes,
                    quantia: quantia,
                    via: via,
                  )); // Center
                },
              ),
            ); // Page
            var data = await pdf.save();
            Uint8List bytes = Uint8List.fromList(data);
            final blob = html.Blob([bytes], 'application/pdf');
            final url = html.Url.createObjectUrlFromBlob(blob);
            final anchor =
                html.document.createElement('a') as html.AnchorElement
                  ..href = url
                  ..style.display = 'none'
                  ..download = 'some_name.pdf';

            html.document.body!.children.add(anchor);
            anchor.click();
            html.document.body!.children.remove(anchor);
            html.Url.revokeObjectUrl(url);
          },
        ),
      ],
    );
  }
}
