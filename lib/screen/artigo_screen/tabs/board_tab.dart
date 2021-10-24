import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/screen/artigo_screen/widgets/tile_widget.dart';

class BoardTab extends StatelessWidget {
  // final BuildContext esseKRai;
  const BoardTab(
      // this.esseKRai,
      {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: context.watch<ArtigoController>().screenshotController,
      child: SizedBox(
          width: 600,
          height: 600,
          // height: double.minPositive,
          // color: Colors.amber,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 75,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemCount: context.read<BoardController>().allTiles.length,
            itemBuilder: (BuildContext essefsdfdsfKRai, int index) {
              if (index == 1 ||
                  index == 3 ||
                  index == 5 ||
                  index == 7 ||
                  index == 8 ||
                  index == 10 ||
                  index == 12 ||
                  index == 14 ||
                  index == 17 ||
                  index == 19 ||
                  index == 21 ||
                  index == 23 ||
                  index == 24 ||
                  index == 26 ||
                  index == 28 ||
                  index == 30 ||
                  index == 33 ||
                  index == 35 ||
                  index == 37 ||
                  index == 39 ||
                  index == 40 ||
                  index == 42 ||
                  index == 44 ||
                  index == 46 ||
                  index == 49 ||
                  index == 51 ||
                  index == 53 ||
                  index == 55 ||
                  index == 56 ||
                  index == 58 ||
                  index == 60 ||
                  index == 62) {
                return TileWidget(
                  index,
                  isWhite: true,
                );
              } else {
                return TileWidget(
                  index,
                  isWhite: false,
                );
              }
            },
          )),
    );
  }
}
