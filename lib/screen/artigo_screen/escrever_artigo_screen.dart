import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:topxadrez/commun/utils.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/screen/artigo_screen/tabs/text_editing_modal.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/write_choice_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class EscreverArtigoScreen extends StatefulWidget {
  const EscreverArtigoScreen({Key? key}) : super(key: key);

  @override
  State<EscreverArtigoScreen> createState() => _EscreverArtigoScreenState();
}

class _EscreverArtigoScreenState extends State<EscreverArtigoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isDestaque = false;
  @override
  void initState() {
    if (context.read<ArtigoController>().toUpdateArt?.titulo != null) {
      context.read<ArtigoController>().newTitle =
          context.read<ArtigoController>().toUpdateArt!.titulo;
    }
    isDestaque = context.read<ArtigoController>().isUpdating
        ? context.read<ArtigoController>().toUpdateArt!.isDestaque
        : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController title =
        TextEditingController(text: context.read<ArtigoController>().newTitle);
    final List<dynamic> listToAnalise =
        context.watch<ArtigoController>().newArtigo;
    return Consumer<ArtigoController>(
      builder: (context, artigoController, __) {
        return Column(
          children: [
            Text(
              artigoController.isUpdating
                  ? 'Edite o artigo e salve as alterações'
                  : 'Escreva um artigo para publicar no site.',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: title,
                onChanged: (text) {
                  context.read<ArtigoController>().newTitle = text;
                },
                validator: (String? value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Digite algo...';
                    }
                    if (value.length < 5) {
                      return 'Precisa ter, ao menos, 5 caracteres...';
                    }
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 4, 125, 141)),
                  hintStyle: TextStyle(color: Color.fromARGB(255, 4, 125, 141)),
                  labelText: 'Nome do Artigo',
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Colocar publicação nos destaques?'),
                const Spacer(),
                const Text('NÃO '),
                Switch(
                  activeColor: const Color(0xff2074ac),
                  value: isDestaque,
                  onChanged: (bool valor) {
                    setState(() {
                      isDestaque = valor;
                    });
                  },
                ),
                const Text('SIM'),
              ],
            ),
            const SizedBox(height: 16),
            ReorderableListView(
              shrinkWrap: true,
              children: listToAnalise.map((artigo) {
                Widget icon = Container(
                  margin: const EdgeInsets.only(right: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: listToAnalise.indexOf(artigo) == 0
                            ? null
                            : () {
                                int index = listToAnalise.indexOf(artigo);
                                context
                                    .read<ArtigoController>()
                                    .switchPlace(true, artigo, index);
                              },
                        icon: const Icon(Icons.arrow_circle_up_rounded),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Center(
                              child: Container(
                                height: 120,
                                width: 300,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Deletar arquivo?',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 4, 125, 141),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff2074ac)),
                                      child: const Text('Voltar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        artigoController.addTexto(artigo,
                                            remove: true);
                                        artigoController.imagesToBeDeleted
                                            .add(artigo);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xff2074ac)),
                                      child: const Text('Sim'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: listToAnalise.indexOf(artigo) ==
                                listToAnalise.length - 1
                            ? null
                            : () {
                                int index = listToAnalise.indexOf(artigo);
                                context
                                    .read<ArtigoController>()
                                    .switchPlace(false, artigo, index);
                              },
                        icon: const Icon(Icons.arrow_circle_down_rounded),
                      ),
                    ],
                  ),
                );
                if (artigo is String) {
                  if (artigo.contains('firebase')) {
                    return Row(
                      key: ValueKey(const Uuid().v1()),
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 100,
                          width: 100,
                          child: Image(
                            image: CachedNetworkImageProvider(artigo),
                          ),
                        ),
                        const Spacer(),
                        icon,
                      ],
                    );
                  }
                  if (artigo.contains('isBOLD')) {
                    return Row(
                      key: ValueKey(const Uuid().v1()),
                      children: [
                        Container(
                          width: 670,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            artigo.replaceAll('isBOLD', '').trim(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 4, 125, 141),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        icon,
                      ],
                    );
                  }
                  if (artigo.startsWith('https://www.youtube.com/watch?v=')) {
                    try {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        key: ValueKey(const Uuid().v1()),
                        child: Row(
                          children: [
                            IgnorePointer(
                              ignoring: true,
                              child: SizedBox(
                                height: 300,
                                child: YoutubePlayerControllerProvider(
                                  controller: YoutubePlayerController(
                                    initialVideoId: artigo.replaceAll(
                                        'https://www.youtube.com/watch?v=', ''),
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
                              ),
                            ),
                            const Spacer(),
                            icon,
                          ],
                        ),
                      );
                    } catch (e) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        key: ValueKey(const Uuid().v1()),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.all(16),
                              color: Colors.grey,
                              child: Column(
                                children: [
                                  const Icon(Icons.warning_amber_outlined),
                                  Text(
                                      'link colocado não existe, confira: $artigo'),
                                  Text('erro: $e'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            icon,
                          ],
                        ),
                      );
                    }
                  }
                  return artigo.startsWith('https://chessboardimage.com/')
                      ? Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          key: ValueKey(const Uuid().v1()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: Image.network(artigo),
                              ),
                              const Spacer(),
                              icon,
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          key: ValueKey(const Uuid().v1()),
                          child: Row(
                            children: [
                              Container(
                                width: 670,
                                color: Colors.grey[100],
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      // backgroundColor: Colors.transparent,
                                      builder: (_) => TextEditingModal(
                                        primaryContext: context,
                                        initialText: artigo,
                                        index: artigoController.newArtigo
                                            .indexOf(artigo),
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      artigo,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              icon,
                            ],
                          ),
                        );
                } else if (artigo is Uint8List) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    key: ValueKey(const Uuid().v1()),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.memory(artigo),
                        ),
                        const Spacer(),
                        icon,
                      ],
                    ),
                  );
                } else {
                  return Row(
                    children: [
                      Container(
                        key: ValueKey(const Uuid().v1()),
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(16),
                        color: Colors.grey,
                        child: Column(
                          children: const [
                            Icon(Icons.warning_amber_outlined),
                            Text(
                              'erro inesperado :(\ntalvez tenha colocado um arquivo incompativel',
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      icon,
                    ],
                  );
                }
              }).toList(),
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                artigoController.setList(oldI: oldIndex, newI: newIndex);
              },
            ),
            const SizedBox(height: 16),
            WriteChoise(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                try {
                  await artigoController.uploadArtigos(
                      title: title.text, isDes: isDestaque);
                  context.read<BoardController>().positionZero();
                  Utils.buildErrorMensage(context,
                      text: 'SUCESSO!', color: Colors.green);
                  context.read<ScreenController>().currentPage = 0;
                } catch (e) {
                  Utils.buildErrorMensage(context, error: e);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
