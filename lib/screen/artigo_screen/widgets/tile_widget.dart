import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/board_controller.dart';

class TileWidget extends StatelessWidget {
  final int index;
  final bool isWhite;
  // final BuildContext myContext;
  const TileWidget(this.index,
      // this.myContext,
      {Key? key,
      this.isWhite = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        context
            .read<BoardController>()
            .setAllTiles(index: index, newPiece: data);
        context.read<BoardController>().currentMovePiece = null;
      },
      onLeave: (data) {},
      builder: (myContexst, canditateData, rejectedData) {
        return Stack(
          children: [
            Container(
              color: isWhite ? Colors.green[700] : Colors.grey[300],
              width: 75,
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text((index).toString()),
                ],
              ),
            ),
            if (context.watch<BoardController>().allTiles[index] != null)
              Draggable<String>(
                onDragCompleted: () {
                  // boardController.currentMovePiece = null;
                },
                onDragEnd: (f) {
                  // if (f.wasAccepted) {
                  //   print('corno');
                  //   piecesController.currentMovePiece = null;
                  // }
                  context.read<BoardController>().currentMovePiece = null;
                },
                onDragStarted: () {
                  context.read<BoardController>().currentMovePiece = index;
                },
                data: context.watch<BoardController>().allTiles[index],
                child: Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                        context.watch<BoardController>().allTiles[index]!),
                  ),
                ),
                feedback: Center(
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                        context.watch<BoardController>().allTiles[index]!),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.6,
                  child: Center(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        context.watch<BoardController>().allTiles[index]!,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
