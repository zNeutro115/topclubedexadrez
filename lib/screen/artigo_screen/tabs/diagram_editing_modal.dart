import 'package:flutter/material.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/screen/artigo_screen/tabs/board_tab.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/pieces_row.dart';
import 'package:provider/provider.dart';

class DiagramEditingModal extends StatelessWidget {
  // final BuildContext mycontext;
  const DiagramEditingModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        width: 600,
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
              const PiecesRow(isWhite: false),
              const SizedBox(height: 16),
              const BoardTab(),
              const SizedBox(height: 16),
              const PiecesRow(isWhite: true),
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
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<BoardController>().cleanBoard();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac)),
                      child: const Text('Zerar Tabuleiro'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<BoardController>().positionZero();
                        // context.read<ScreenController>().currentPage = 7;
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2074ac)),
                      child: const Text('Posição inicial'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ArtigoController>().addTexto(
                            context.read<BoardController>().boardToLink());
                        context.read<ScreenController>().currentPage = 7;
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
