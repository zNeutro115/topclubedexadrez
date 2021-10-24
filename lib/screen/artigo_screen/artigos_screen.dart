import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/helpers/artigos_types.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/artigo_tile.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/search_filter_widget.dart';

class ArtigoScreen extends StatelessWidget {
  const ArtigoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtigoController>(
      builder: (context, artigoController, _) {
        String text = artigoController.artType;
        return Column(
          children: [
            Text(
              text == ArtigoTypes.quem
                  ? 'Quem Somos? Descubra mais sobre o Top Clube de Xadrez:'
                  : text == ArtigoTypes.artigo
                      ? 'Leia sobre diversos tipos de temas e ganhe amplie seu conhecimento no Xadrex.'
                      : 'Veja todos os Eventos já feitos pelo Top Clube de Xadrez:',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
            VisibilityWidget(
              nivel: VisibilityWidget.admin,
              text: text == ArtigoTypes.quem
                  ? 'Adicionar Categoria'
                  : text == ArtigoTypes.artigo
                      ? 'Escrever novo artigo'
                      : 'Adicionar Evento',
              page: 7,
            ),
            if (artigoController.artigos.isEmpty)
              SizedBox(
                width: 100,
                height: 100,
                child: Utils.progress(),
              ),
            if (artigoController.artigos.isNotEmpty) SearchFilter(),
            if (artigoController.artigos.isNotEmpty) const ArtigoTile(),
          ],
        );
      },
    );
  }
}
