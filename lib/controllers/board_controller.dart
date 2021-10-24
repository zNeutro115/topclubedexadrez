import 'package:flutter/cupertino.dart';

class BoardController extends ChangeNotifier {
  BoardController() {
    allTiles.addAll([
      'icons/rook_black.png', // 0
      'icons/knight_black.png', // 1
      'icons/bishop_black.png', // 2
      'icons/queen_black.png', // 3
      'icons/king_black.png', // 4
      'icons/bishop_black.png', // 5
      'icons/knight_black.png', // 6
      'icons/rook_black.png', // 7
      'icons/pawn_black.png', // 8
      'icons/pawn_black.png', // 9
      'icons/pawn_black.png', // 10
      'icons/pawn_black.png', // 11
      'icons/pawn_black.png', // 12
      'icons/pawn_black.png', // 13
      'icons/pawn_black.png', // 14
      'icons/pawn_black.png', // 15
      null, // 16
      null, // 17
      null, // 18
      null, // 19
      null, // 20
      null, // 21
      null, // 22
      null, // 23
      null, // 24
      null, // 25
      null, // 26
      null, // 27
      null, // 28
      null, // 29
      null, // 30
      null, // 31
      null, // 32
      null, // 33
      null, // 34
      null, // 35
      null, // 36
      null, // 37
      null, // 38
      null, // 39
      null, // 40
      null, // 41
      null, // 42
      null, // 43
      null, // 44
      null, // 45
      null, // 46
      null, // 47
      'icons/pawn_white.png', // 48
      'icons/pawn_white.png', // 49
      'icons/pawn_white.png', // 50
      'icons/pawn_white.png', // 51
      'icons/pawn_white.png', // 52
      'icons/pawn_white.png', // 53
      'icons/pawn_white.png', // 54
      'icons/pawn_white.png', // 55
      'icons/rook_white.png', // 56
      'icons/knight_white.png', // 57
      'icons/bishop_white.png', // 58
      'icons/queen_white.png', // 59
      'icons/king_white.png', // 60
      'icons/bishop_white.png', // 61
      'icons/knight_white.png', // 62
      'icons/rook_white.png', // 63
    ]);
  }
  List<String?> _allTiles = [];

  List<String?> get allTiles => _allTiles;
  void changeTile(String? string, int num) {
    _allTiles[num] = string;
    notifyListeners();
  }

  void cleanBoard() {
    List<String?> _emptyList = List.generate(64, (i) {
      return null;
    });
    _allTiles = _emptyList;
    notifyListeners();
  }

  void positionZero() {
    List<String?> _emptyList = List.generate(64, (i) {
      if (i == 0 || i == 7) {
        return 'icons/rook_black.png';
      } else if (i == 1 || i == 6) {
        return 'icons/knight_black.png';
      } else if (i == 2 || i == 5) {
        return 'icons/bishop_black.png';
      } else if (i == 3) {
        return 'icons/queen_black.png';
      } else if (i == 4) {
        return 'icons/king_black.png';
      } else if (7 < i && i < 16) {
        return 'icons/pawn_black.png';
      } else if (i == 56 || i == 63) {
        return 'icons/rook_white.png';
      } else if (i == 57 || i == 62) {
        return 'icons/knight_white.png';
      } else if (i == 58 || i == 61) {
        return 'icons/bishop_white.png';
      } else if (i == 59) {
        return 'icons/queen_white.png';
      } else if (i == 60) {
        return 'icons/king_white.png';
      } else if (47 < i && i < 56) {
        return 'icons/pawn_white.png';
      }
      return null;
    });
    _allTiles = _emptyList;
    notifyListeners();
  }

  String boardToLink() {
    int numberTotalRow = 0;
    int numberEmpty = 0;
    // int times = 0;
    // int row = 1;
    String link = 'https://chessboardimage.com/';
    void calcRow(String? piece) {
      if (piece == null) {
        if (numberTotalRow < 8) {
          numberEmpty++;
          numberTotalRow++;
        } else {
          link = link + numberEmpty.toString();
          numberTotalRow = 1;
          numberEmpty = 1;
          // print('vamo ver como ta aqui: $link');
        }
        // print('emprty: $numberEmpty');
        // print('row: $numberTotalRow');
        // times++;
        // print('time: $times');
        // print('#######################');
      } else {
        if (numberEmpty != 0) {
          // print('entrou numero enpty');
          link = link + numberEmpty.toString();
          // print('vamo ver como ta aqui 2: $link');
        }
        link = link + piece;
        numberEmpty = 0;
        if (numberTotalRow < 8) {
          numberTotalRow++;
        } else {
          numberTotalRow = 0;
        }
        // times++;
      }
    }

    for (String? element in _allTiles) {
      switch (element) {
        case ('icons/bishop_black.png'):
          debugPrint(element);
          calcRow('b');
          break;
        case ('icons/king_black.png'):
          debugPrint(element);
          calcRow('k');
          break;
        case ('icons/knight_black.png'):
          debugPrint(element);
          calcRow('n');
          break;
        case ('icons/pawn_black.png'):
          debugPrint(element);
          calcRow('p');
          break;
        case ('icons/queen_black.png'):
          debugPrint(element);
          calcRow('q');
          break;
        case ('icons/rook_black.png'):
          debugPrint(element);
          calcRow('r');
          break;
        case ('icons/bishop_white.png'):
          debugPrint(element);
          calcRow('B');
          break;
        case ('icons/king_white.png'):
          debugPrint(element);
          calcRow('K');
          break;
        case ('icons/knight_white.png'):
          debugPrint(element);
          calcRow('N');
          break;
        case ('icons/pawn_white.png'):
          debugPrint(element);
          calcRow('P');
          break;
        case ('icons/queen_white.png'):
          debugPrint(element);
          calcRow('Q');
          break;
        case ('icons/rook_white.png'):
          debugPrint(element);
          // String currentText = link;
          // link = currentText + 'R';
          calcRow('R');
          break;
        default:
          calcRow(null);
          break;
      }
    }
    debugPrint(link + '.png');
    return link + '.png';
  }

  void setAllTiles({required int index, String? newPiece}) {
    if (_currentMovePiece != null && index != _currentMovePiece) {
      _allTiles[index] = _allTiles[_currentMovePiece!];
      _allTiles[_currentMovePiece!] = null;
      // print('current 2 ' + currentMovePiece.toString());
      // currentMovePiece = null;

    }
    if (_currentMovePiece == null && newPiece != null) {
      allTiles[index] = newPiece;
      notifyListeners();
    }
  }

  void deletePiece() {
    if (currentMovePiece != null) {
      _allTiles[currentMovePiece!] = null;
      notifyListeners();
    }
  }

  //current piece that the player is moving (you can only move your piece)
  int? _currentMovePiece = 0;
  int? get currentMovePiece => _currentMovePiece;

  set currentMovePiece(int? index) {
    _currentMovePiece = index;

    notifyListeners();
  }

  //piece that is selected to view stats(not nescesarry your piece)

}
