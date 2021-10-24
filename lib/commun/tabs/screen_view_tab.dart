import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/controllers/user_controller.dart';
import 'package:topxadrez/helpers/artigos_types.dart';

class ScreenTabView extends StatelessWidget {
  const ScreenTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildTextSwitcher(String text, int index, int indexTwo) {
      bool isSelected =
          context.watch<ScreenController>().currentPage == index ||
              context.watch<ScreenController>().currentPage == indexTwo;

      return TextButton(
        style: ButtonStyle(
          backgroundColor: isSelected
              ? MaterialStateProperty.all<Color>(Colors.white)
              : MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 4, 125, 141)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              // side: BorderSide(color: Colors.white),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? const Color.fromARGB(255, 4, 125, 141)
                : Colors.white,
            fontSize: isSelected ? 18 : 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onPressed: () {
          context.read<ScreenController>().currentPage = index;
          if (text == 'Artigos') {
            context.read<ArtigoController>().artType = ArtigoTypes.artigo;
            context.read<ArtigoController>().artigos =
                context.read<ArtigoController>().artigosXadrex;
            context.read<ArtigoController>().filteredArtigos =
                context.read<ArtigoController>().artigosXadrex;
          } else if (text == 'Quem somos') {
            context.read<ArtigoController>().artType = ArtigoTypes.quem;
            context.read<ArtigoController>().artigos =
                context.read<ArtigoController>().quemSomos;
            context.read<ArtigoController>().filteredArtigos =
                context.read<ArtigoController>().quemSomos;
          } else if (text == 'Eventos') {
            context.read<ArtigoController>().artType = ArtigoTypes.eventos;
            context.read<ArtigoController>().artigos =
                context.read<ArtigoController>().eventos;
            context.read<ArtigoController>().filteredArtigos =
                context.read<ArtigoController>().eventos;
          } else {
            context.read<ArtigoController>().artigos =
                context.read<ArtigoController>().isDestaque;
            context.read<ArtigoController>().filteredArtigos =
                context.read<ArtigoController>().isDestaque;
          }
          debugPrint(
            'current: ${context.read<ScreenController>().currentPage}',
          );
          Utils.zerarTudo(context);
        },
      );
    }

    return Container(
      color: const Color.fromARGB(255, 4, 125, 141),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildTextSwitcher('Destaque', 0, 20),
          buildTextSwitcher('Artigos', 1, 20),
          buildTextSwitcher('Calendário', 2, 6),
          buildTextSwitcher('Loja', 3, 4),
          buildTextSwitcher('Eventos', 11, 20),
          buildTextSwitcher('Quem somos', 9, 20),
          if (context.watch<UserController>().currentUser != null)
            if (context.watch<UserController>().currentUser!.isAdmin)
              buildTextSwitcher('Associados', 13, 20),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 4, 125, 141),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  // side: BorderSide(color: Colors.white),
                ),
              ),
            ),
            child: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              context.read<ScreenController>().currentPage = 12;
              // showDialog(
              //     context: context,
              //     builder: (_) => const ConfigurationScreen());
            },
          )
        ],
      ),
    );
  }
}
