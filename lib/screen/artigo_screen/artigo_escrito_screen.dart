import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ArtigoEscritoScreen extends StatelessWidget {
  const ArtigoEscritoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArtigoController>(
      builder: (context, artigoManager, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            VisibilityWidget(
              nivel: VisibilityWidget.admin,
              onPressed: () async {
                artigoManager.transformToEditArtigo(
                  artigoManager.artigos[artigoManager.currentArtigo],
                );
                artigoManager.isUpdating = true;
                context.read<ScreenController>().currentPage = 7;
              },
              text: 'Editar Artigo',
            ),
            const SizedBox(height: 8),
            Text(
              artigoManager.artigos[artigoManager.currentArtigo].titulo,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
            if (artigoManager.artigos[artigoManager.currentArtigo].createdAt !=
                null)
              Text(
                'Publicado dia '
                '${artigoManager.artigos[artigoManager.currentArtigo].createdAt!.toDate().day} '
                'de ${artigoManager.artigos[artigoManager.currentArtigo].createdAt!.toDate().month},'
                ' ${artigoManager.artigos[artigoManager.currentArtigo].createdAt!.toDate().year}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(height: 8),
            ...artigoManager.artigos[artigoManager.currentArtigo].conteudo
                .map((e) {
              if (e['type'] == 'text') {
                return Text(
                  e['content'],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                );
              }
              if (e['type'] == 'diagram') {
                return Container(
                  margin: const EdgeInsets.all(16),
                  height: 300,
                  width: 300,
                  child: Image.network(e['content']),
                );
              }
              if (e['type'] == 'bold') {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    e['content'],
                    style: const TextStyle(
                      color: Color.fromARGB(255, 4, 125, 141),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if (e['type'] == 'video') {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 120),
                  child: YoutubePlayerControllerProvider(
                    // Provides controller to all the widget below it.
                    controller: YoutubePlayerController(
                      initialVideoId: e['content']
                          .replaceAll('https://www.youtube.com/watch?v=', ''),
                      // initialVideoId: 'K18cpp_-gP8',
                      params: const YoutubePlayerParams(
                        startAt: Duration(seconds: 0),
                        showControls: true,
                        showFullscreenButton: true,
                      ),
                    ),
                    child: const YoutubePlayerIFrame(
                      aspectRatio: 16 / 9,
                    ),
                  ),
                );
              }
              if (e['type'] == 'image') {
                return Container(
                  margin: const EdgeInsets.all(16),
                  height: 100,
                  width: 100,
                  child: Image(
                    image: CachedNetworkImageProvider(e['content']),
                  ),
                );
              }
              return Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
