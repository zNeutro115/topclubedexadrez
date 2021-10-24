import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/helpers/artigos_types.dart';
import 'package:topxadrez/models/artigo_model.dart';

class ArtigoTile extends StatefulWidget {
  const ArtigoTile({Key? key}) : super(key: key);
  @override
  _ArtigoTileState createState() => _ArtigoTileState();
}

class _ArtigoTileState extends State<ArtigoTile> {
  Widget textoGenerico(
      String headler, BuildContext context, int index, Artigo artigo,
      {bool isNovo = false}) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 4, 125, 141),
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          context.read<ArtigoController>().currentArtigo = index;
          context.read<ScreenController>().currentPage = 5;
        },
        child: Row(
          children: [
            const SizedBox(width: 4),
            Icon(
              artigo.type == ArtigoTypes.artigo
                  ? Icons.book
                  : artigo.type == ArtigoTypes.eventos
                      ? Icons.event
                      : Icons.people,
              size: 40,
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                if (isNovo)
                  const Text(
                    'Novo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                Text(
                  headler,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 125, 141),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: context.watch<ArtigoController>().filteredArtigos.length,
      itemBuilder: (BuildContext context, int index) {
        return textoGenerico(
          context.read<ArtigoController>().filteredArtigos[index].titulo,
          context,
          index,
          context.watch<ArtigoController>().filteredArtigos[index],
        );
      },
    );
  }
}
