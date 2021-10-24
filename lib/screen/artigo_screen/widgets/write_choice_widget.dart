import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/commun/widgets/custom_dialog.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/page_controller.dart';
import 'package:topxadrez/screen/artigo_screen/tabs/text_editing_modal.dart';
import 'package:provider/provider.dart';

class WriteChoise extends StatelessWidget {
  final void Function()? onPressed;

  const WriteChoise({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => TextEditingModal(primaryContext: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff2074ac),
                ),
                child: const Text('Adicionar Texto'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  //Selecionar arquivo
                  FilePickerResult? resultado =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  //Recuperar o arquivo
                  if (resultado != null) {
                    context
                        .read<ArtigoController>()
                        .addTexto(resultado.files.single.bytes);
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff2074ac)),
                child: const Text('Adicionar Imagem'),
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
                  showDialog(
                    context: context,
                    builder: (_) => TextEditingModal(
                      primaryContext: context,
                      isLinkYoutube: true,
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff2074ac)),
                child: const Text('Adicionar Video'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ScreenController>().currentPage = 8;
                },
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xff2074ac)),
                child: const Text('Adicionar Diagrama'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        VisibilityWidget(
          text: 'Salvar Artigo',
          onPressed: () async {
            onPressed;
          },
        ),
        const SizedBox(height: 8),
        if (context.watch<ArtigoController>().isUpdating)
          Container(
            height: 35,
            width: 93,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Center(
              child: SizedBox(
                width: 123,
                child: CustomDialogPopup(
                  text: 'DELETAR ARTIGO',
                  modals: [
                    CustomDialogPopup.buildPopupModal(
                      'Clique para continuar',
                      () {
                        context.read<ArtigoController>().deleteArtigo();
                      },
                      textHeadler: 'Tem certeza?',
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
