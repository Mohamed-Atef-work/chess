import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/utils/extensions/castling_extension.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

import '../../utils/models/square_content.dart';

class King extends Piece {
  King({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.king,
    super.image = PiecesImages.king,
  });

  @override
  ChessState move(ChessState state, int to) {
    if (isShortCastlingAvailable(state) &&
        ((state.isWhite && to == 62) || (!state.isWhite && to == 57))) {
      return castleShort(state);
    } else if (isLongCastlingAvailable(state) &&
        ((state.isWhite && to == 58) || (!state.isWhite && to == 61))) {
      return castleLong(state);
    } else {
      final newState = super.move(state, to);
      return newState.copyWith(
        kingMoved: true,
        king: to,
      );
    }
  }

  @override
  List<int> availableMoves(ChessState state, int position) {
    final ordinarySquares = ordinaryMoves(state, position);

    print("ordinarySquares---------->$ordinarySquares");
    List<int> elementsToBeRemoved = [];

    for (int ordinary in ordinarySquares) {
      print("ordinary-----------------> $ordinary");
      final besideOtherKing = isBesideOtherKing(ordinary, state);
      print("-------------------besideOtherKing-----------------");
      print(besideOtherKing);
      if (besideOtherKing) {
        elementsToBeRemoved.add(ordinary);
      }
    }

    for (int element in elementsToBeRemoved) {
      ordinarySquares.remove(element);
    }

    return ordinarySquares;
  }

  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    List<int> availableMoves = [];

    final piecesPositions =
        super.piecesPositionsFromContent(state.squareContent);

    super.calcRowAndColumn(position);
    if (row != 1 && piecesPositions[position - 8] != true) {
      availableMoves.add(position - 8);
    }
    if (row != 8 && piecesPositions[position + 8] != true) {
      availableMoves.add(position + 8);
    }
    if (column != 1 && piecesPositions[position - 1] != true) {
      availableMoves.add(position - 1);
    }
    if (column != 8 && piecesPositions[position + 1] != true) {
      availableMoves.add(position + 1);
    }
    if (row != 1 && column != 8 && piecesPositions[position - 7] != true) {
      availableMoves.add(position - 7);
    }
    if (row != 1 && column != 1 && piecesPositions[position - 9] != true) {
      availableMoves.add(position - 9);
    }
    if (column != 8 && row != 8 && piecesPositions[position + 9] != true) {
      availableMoves.add(position + 9);
    }
    if (column != 1 && row != 8 && piecesPositions[position + 7] != true) {
      availableMoves.add(position + 7);
    }

    final shortCastle = isShortCastlingAvailable(state);
    if (shortCastle) {
      if (state.isWhite) {
        availableMoves.add(62);
      } else {
        availableMoves.add(57);
      }
    }

    final longCastle = isLongCastlingAvailable(state);
    if (longCastle) {
      if (state.isWhite) {
        availableMoves.add(58);
      } else {
        availableMoves.add(61);
      }
    }

    /// ------------------------------------
    final editedMoves = removeCheckedSquares(availableMoves, state);

    /// ------------------------------------

    return editedMoves;
  }

  List<int> removeCheckedSquares(List<int> ordinaryMoves, ChessState state) {
    List<int> elementsToBeRemoved = [];

    List<SquareContent> content = contentFrom(state.squareContent);
    content[state.king].piece = null;

    print("ordinary moves------------------------------>$ordinaryMoves");

    for (int element in ordinaryMoves) {
      print("check on Square -----------------> [$element]");
      final isChecked = isSquareChecked(content, element);
      print("check on Square -----------------> [$element] ---------> done");

      print("$element --------> ${isChecked.toString()}");

      if (isChecked.isDouble || isChecked.isChecked) {
        elementsToBeRemoved.add(element);
      }
    }

    for (int element in elementsToBeRemoved) {
      ordinaryMoves.remove(element);
    }

    return ordinaryMoves;
  }

  bool isBesideOtherKing(int position, ChessState state) {
    final content = contentFrom(state.squareContent);
    super.calcRowAndColumn(position);
    if (row != 1 &&
        content[position - 8].piece is King &&
        !content[position - 8].piece!.isMyPiece) {
      print("content[position - 8].piece is King");
      print(content[position - 8].piece is King);
      print("content[position - 8].piece!.isMyPiece");
      print(content[position - 8].piece!.isMyPiece);

      return true;
    }
    if (row != 8 &&
        content[position + 8].piece is King &&
        !content[position + 8].piece!.isMyPiece) {
      return true;
    }
    if (column != 1 &&
        content[position - 1].piece is King &&
        !content[position - 1].piece!.isMyPiece) {
      return true;
    }
    if (column != 8 &&
        content[position + 1].piece is King &&
        !content[position + 1].piece!.isMyPiece) {
      return true;
    }
    if (row != 1 &&
        column != 8 &&
        content[position - 7].piece is King &&
        !content[position - 7].piece!.isMyPiece) {
      return true;
    }
    if (row != 1 &&
        column != 1 &&
        content[position - 9].piece is King &&
        !content[position - 9].piece!.isMyPiece) {
      return true;
    }
    if (column != 8 &&
        row != 8 &&
        content[position + 9].piece is King &&
        !content[position + 9].piece!.isMyPiece) {
      return true;
    }
    if (column != 1 &&
        row != 8 &&
        content[position + 7].piece is King &&
        !content[position + 7].piece!.isMyPiece) {
      return true;
    }

    return false;
  }
}
