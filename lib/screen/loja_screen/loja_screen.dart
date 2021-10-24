import 'package:flutter/material.dart';
import 'package:topxadrez/commun/visibility_button.dart';
import 'package:topxadrez/controllers/loja_controller.dart';
import 'package:topxadrez/screen/loja_screen/widgets/product_tile.dart';

import 'package:provider/provider.dart';

class LojaScreen extends StatelessWidget {
  const LojaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VisibilityWidget(
          nivel: VisibilityWidget.admin,
          text: 'Cadastrar novo produto',
          page: 10,
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 210,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: context.watch<LojaController>().products.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: ProductTile(index: index),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
            );
          },
        ),
      ],
    );
  }
}
