import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/artigo_tile.dart';
import 'package:topxadrez/screen/destaque_screen/widgets/current_tornament.dart';

class DestaqueScreen extends StatelessWidget {
  const DestaqueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EventoDestaqueTile(),
        SizedBox(height: 8),
        ArtigoTile(),
      ],
    );
  }
}
