import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/artigo_controller.dart';
import 'package:topxadrez/controllers/board_controller.dart';
import 'package:topxadrez/controllers/calendar_controller.dart';
import 'package:topxadrez/controllers/loja_controller.dart';

class Utils extends ChangeNotifier {
  static buildErrorMensage(
    BuildContext context, {
    Object error = '',
    Color? color,
    String text =
        '  Erro desconhecido, favor notificar o tecnico da equipe.\n  Erro:',
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$text $error',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color ?? Colors.red,
      ),
    );
  }

  static zerarTudo(BuildContext context) {
    BoardController board = context.read<BoardController>();
    ArtigoController art = context.read<ArtigoController>();
    LojaController loja = context.read<LojaController>();
    CalendarController calendar = context.read<CalendarController>();
    board.positionZero();
    art.isUpdating = false;
    art.zerarUpdateArt();
    art.imagesToBeDeleted = [];
    art.newTitle = '';
    loja.currentCep = '';
    loja.currentProduc = null;
    loja.zerarImages();
    calendar.compromiss = '';
    calendar.idOfUser = '';
    calendar.isOnline = false;
    calendar.isEventUpdating = false;
    calendar.dateTime = null;
    calendar.color = 0;
    calendar.hour = null;
  }

  static Widget progress() {
    return Container(
      padding: const EdgeInsets.all(2),
      child: const CircularProgressIndicator(),
    );
  }
}
