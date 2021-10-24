import 'package:flutter/material.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:provider/provider.dart';

class DiagramModal extends StatelessWidget {
  // final BuildContext mycontext;
  const DiagramModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.8,
        // height: 600,
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: 600,
        height: 600,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Crie um diagrama para ilustrar uma posição.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 125, 141),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ScreenController>().currentPage = 7;
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac)),
                      child: const Text('Voltar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<BoardController>().boardToLink();
                        // await context.read<ArtigoController>().
                        // await context.read<ArtigoController>()
                        //     .screenshotController
                        //     .capture()
                        //     .then((Uint8List? image) {
                        //   print('tá cá');
                        //   // print(image);
                        //   // print(image);
                        //   if (image != null) {
                        //     print('tá cá 2');
                        //     context.read<ArtigoController>().addTexto(image);
                        //   }
                        //   context.read<ScreenController>().currentPage = 7;
                        // }).catchError((onError) {
                        //   print('tá cá erro');
                        //   debugPrint(onError.toString());
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac)),
                      child: const Text('Adicionar Diagrama ao texto'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
