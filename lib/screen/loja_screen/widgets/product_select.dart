import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/commun/widgets/custom_dialog.dart';
import 'package:topxadrez/controllers/loja_controller.dart';

class ProductSelect extends StatelessWidget {
  const ProductSelect({Key? key}) : super(key: key);
  Widget imageChooseWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        FilePickerResult? resultado =
            await FilePicker.platform.pickFiles(type: FileType.image);
        if (resultado != null) {
          context
              .read<LojaController>()
              .setImages(resultado.files.single.bytes!);
        }
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.grey[400],
        child: const Center(
          child: Icon(Icons.image),
        ),
      ),
    );
  }

  Widget imageShowUnitImage(BuildContext context, Uint8List image) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomDialogPopup(
        text: 'DELETAR IMAGEM',
        modals: [
          CustomDialogPopup.buildPopupModal(
            'Clique para continuar',
            () {
              if (context.read<LojaController>().images.contains(image)) {
                context.read<LojaController>().removeImage(image);
              }
            },
            textHeadler: 'Tem certeza?',
          ),
        ],
        icon: Container(
          width: 100,
          height: 100,
          color: Colors.grey[400],
          child: Image.memory(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget imageShowCashedImage(BuildContext context, String image) {
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomDialogPopup(
        text: 'DELETAR IMAGEM',
        modals: [
          CustomDialogPopup.buildPopupModal(
            'Clique para continuar',
            () {
              context.read<LojaController>().removeString(image);
              context.read<LojaController>().imagesToBeDeleted.add(image);
            },
            textHeadler: 'Tem certeza?',
          ),
        ],
        icon: Image(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: context.watch<LojaController>().images.isEmpty &&
              context.watch<LojaController>().currentProduc == null
          ? [
              imageChooseWidget(context),
            ]
          : [
              if (context.watch<LojaController>().currentProduc != null)
                ...context
                    .watch<LojaController>()
                    .currentProduc!
                    .images!
                    .map((e) {
                  debugPrint('entrou');
                  return imageShowCashedImage(context, e);
                }).toList(),
              ...context.watch<LojaController>().images.map(
                (e) {
                  return imageShowUnitImage(context, e);
                },
              ).toList(),
              imageChooseWidget(context),
            ],
    );
  }
}
