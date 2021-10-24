import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/board_controller.dart';

class PiecesRow extends StatelessWidget {
  final bool isWhite;
  const PiecesRow({Key? key, required this.isWhite}) : super(key: key);

  Widget buildPiece(String piece, BuildContext context) {
    return Draggable<String>(
      onDragCompleted: () {
        // context.read<BoardController>().currentMovePiece = null;
        // context.read<BoardController>().setAllTiles();
      },
      onDragEnd: (f) {
        if (f.wasAccepted) {
          // print('corno');
          // context.read<BoardController>().currentMovePiece = null;
        }
      },
      onDragStarted: () {},
      data: piece,
      child: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(piece),
        ),
      ),
      feedback: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(piece),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.6,
        child: Center(
          child: SizedBox(
            height: 60,
            width: 60,
            child: Image.asset(piece),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildPiece(isWhite ? 'icons/rook_white.png' : 'icons/rook_black.png',
              context),
          buildPiece(
              isWhite ? 'icons/bishop_white.png' : 'icons/bishop_black.png',
              context),
          buildPiece(isWhite ? 'icons/king_white.png' : 'icons/king_black.png',
              context),
          buildPiece(
              isWhite ? 'icons/queen_white.png' : 'icons/queen_black.png',
              context),
          buildPiece(isWhite ? 'icons/pawn_white.png' : 'icons/pawn_black.png',
              context),
          buildPiece(
              isWhite ? 'icons/knight_white.png' : 'icons/knight_black.png',
              context),
          DragTarget<String>(
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              if (context.read<BoardController>().currentMovePiece != null) {
                context.read<BoardController>().deletePiece();
              }
              // boardController.currentMovePiece = null;
            },
            builder: (context, canditateData, rejectedData) {
              return const Icon(Icons.delete, color: Colors.red, size: 68);
            },
          ),
        ],
      ),
    );
  }
}
