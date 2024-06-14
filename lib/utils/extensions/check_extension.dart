import 'package:chess/logic/pieces/pawn.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/logic/pieces/rook.dart';
import 'package:chess/logic/pieces/night.dart';
import 'package:chess/logic/pieces/queen.dart';
import 'package:chess/logic/pieces/bishop.dart';
import 'package:chess/utils/models/check_model.dart';

import '../models/square_content.dart';

extension SquareChecked on Piece {
  Check isSquareChecked(List<SquareContent> content, int square) {
    List<int> checkFrom = [];
    int from;

    List<int Function()> searchers = [
      () {
        //print("square is ------------------------------------------->$square");

        final result = _goUp(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _goDown(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _goRight(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _goLeft(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _topRight(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _topLeft(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _bottomRight(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _bottomLeft(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _night(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
      () {
        //print("square is ------------------------------------------->$square");

        final result = _pawn(content, square);
        if (result != -1) {
          return result;
        } else {
          return -1;
        }
      },
    ];

    for (var searcher in searchers) {
      from = searcher();

      if (from != -1) {
        checkFrom.add(from);
      }
      //if (checkFrom.length > 1) {
      //break;
      //}
    }

    Check check;

    if (checkFrom.length == 1) {
      check = Check(
        isDouble: false,
        isChecked: true,
        from: checkFrom.first,
      );
      print(check.toString());
      return check;
    } else if (checkFrom.length > 1) {
      check = const Check(isDouble: true);
      print(check.toString());
      return check;
    } else {
      check = const Check();
      print(check.toString());
      return check;
    }
  }

  int _topRight(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> topRight");
    calcRowAndColumn(position);
    do {
      if (row != 1 &&
          column != 8 &&
          (content[position - 7].piece?.isMyPiece ?? false) == false) {
        position -= 7;
        if (content[position].piece is Bishop ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }

      //print("no check  ${position}");
    } while (true);
  }

  int _topLeft(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> topLeft");

    calcRowAndColumn(position);
    do {
      if (row != 1 &&
          column != 1 &&
          (content[position - 9].piece?.isMyPiece ?? false) == false) {
        position -= 9;

        if (content[position].piece is Bishop ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }

      //print("no check ${position}");
    } while (true);
  }

  int _bottomRight(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _bottomRight");

    calcRowAndColumn(position);
    do {
      if (row != 8 &&
          column != 8 &&
          (content[position + 9].piece?.isMyPiece ?? false) == false) {
        position += 9;

        if (content[position].piece is Bishop ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }

      //print("no check ${position}");
    } while (true);
  }

  int _bottomLeft(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _bottomLeft");

    calcRowAndColumn(position);
    do {
      if (row != 8 &&
          column != 1 &&
          (content[position + 7].piece?.isMyPiece ?? false) == false) {
        position += 7;

        if (content[position].piece is Bishop ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }

      //print("no check ${position}");
    } while (true);
  }

  int _goUp(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _goUp");

    calcRowAndColumn(position);
    do {
      if (row != 1 &&
          (content[position - 8].piece?.isMyPiece ?? false) == false) {
        position -= 8;

        if (content[position].piece is Rook ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }
      //print("no check  ${position}");
    } while (true);
  }

  int _goDown(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _goDown");

    calcRowAndColumn(position);
    do {
      if (row != 8 &&
          (content[position + 8].piece?.isMyPiece ?? false) == false) {
        position += 8;

        if (content[position].piece is Rook ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }
      ////print("no check  ${position}");
    } while (true);
  }

  int _goRight(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _goRight");

    calcRowAndColumn(position);
    do {
      if (column != 8 &&
          (content[position + 1].piece?.isMyPiece ?? false) == false) {
        position += 1;

        if (content[position].piece is Rook ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }
      //print("no check  ${position}");
    } while (true);
  }

  int _goLeft(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _goLeft");

    calcRowAndColumn(position);
    do {
      if (column != 1 &&
          (content[position - 1].piece?.isMyPiece ?? false) == false) {
        position -= 1;

        if (content[position].piece is Rook ||
            content[position].piece is Queen) {
          //print("check is from Here----------------------> ${position}");
          return position;
        }
        if (content[position].piece != null) {
          return -1;
        }
        calcRowAndColumn(position);
      } else {
        return -1;
      }
      //print("no check  ${position}");
    } while (true);
  }

  int _night(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _night");

    calcRowAndColumn(position);

    if (row >= 3 &&
        column <= 7 &&
        checkIfPieceExistsOrTrue(content[position - 15]) &&
        checkIfIsPieceOfType<Night>(content[position - 15])) {
      //print("check is from Here----------------------> ${position - 15}");

      return (position - 15);
    } else if (row <= 6 &&
        column >= 2 &&
        checkIfPieceExistsOrTrue(content[position + 15]) &&
        checkIfIsPieceOfType<Night>(content[position + 15])) {
      //print("check is from Here----------------------> ${position + 15}");

      return (position + 15);
    } else if (row >= 2 &&
        column <= 6 &&
        checkIfPieceExistsOrTrue(content[position - 6]) &&
        checkIfIsPieceOfType<Night>(content[position - 6])) {
      //print("check is from Here----------------------> ${position - 6}");

      return (position - 6);
    } else if (row <= 7 &&
        column >= 3 &&
        checkIfPieceExistsOrTrue(content[position + 6]) &&
        checkIfIsPieceOfType<Night>(content[position + 6])) {
      //print("check is from Here----------------------> ${position + 6}");

      return (position + 6);
    } else if (row >= 3 &&
        column >= 2 &&
        checkIfPieceExistsOrTrue(content[position - 17]) &&
        checkIfIsPieceOfType<Night>(content[position - 17])) {
      //print("check is from Here----------------------> ${position - 17}");

      return (position - 17);
    } else if (row <= 6 &&
        column <= 7 &&
        checkIfPieceExistsOrTrue(content[position + 17]) &&
        checkIfIsPieceOfType<Night>(content[position + 17])) {
      //print("check is from Here----------------------> ${position + 17}");

      return (position + 17);
    } else if (row >= 2 &&
        column >= 3 &&
        checkIfPieceExistsOrTrue(content[position - 10]) &&
        checkIfIsPieceOfType<Night>(content[position - 10])) {
      //print("check is from Here----------------------> ${position - 10}");

      return (position - 10);
    } else if (row <= 7 &&
        column <= 6 &&
        checkIfPieceExistsOrTrue(content[position + 10]) &&
        checkIfIsPieceOfType<Night>(content[position + 10])) {
      //print("check is from Here----------------------> ${position + 10}");

      return (position + 10);
    }

    return -1;
  }

  int _pawn(List<SquareContent> content, int position) {
    //print("---------------------------------------------------> _pawn");

    calcRowAndColumn(position);

    if (row != 1) {
      if (column != 8 &&
          (content[position - 7].piece?.isMyPiece ?? true) == false &&
          content[position - 7].piece is Pawn) {
        //print("check is from Here----------------------> ${position - 7}");

        return (position - 7);
      } else if (column != 1 &&
          content[position - 9].piece?.isMyPiece == false &&
          content[position - 9].piece is Pawn) {
        //print("check is from Here----------------------> ${position - 9}");

        return (position - 9);
      }
    }

    return -1;
  }

  bool checkIfPieceExistsOrTrue(SquareContent square) =>
      (square.piece?.isMyPiece ?? true) == false;

  bool checkIfIsPieceOfType<T>(SquareContent square) => square.piece is T;

  List<SquareContent> contentFrom(List<SquareContent> content) => List.generate(
        content.length,
        (index) => SquareContent(
          mark: content[index].mark,
          piece: content[index].piece,
        ),
      );
}
