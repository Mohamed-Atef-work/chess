import 'package:chess/data/model.dart';
import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/king.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/models/check_model.dart';
import 'package:chess/utils/constants/strings.dart';

import '../enums/square_color.dart';
import '../models/square_content.dart';

extension Castling on King {
  bool isShortCastlingAvailable(ChessState state) {
    if (!state.check.isChecked &&
        !state.check.isDouble &&
        !state.shortRookMoved &&
        !state.kingMoved) {
      if (state.isWhite) {
        final bool isAvailable = isCastlingAvailable(
            state: state, kingPassing: [62, 61], emptySquares: [62, 61]);
        return isAvailable;
      } else {
        final bool isAvailable = isCastlingAvailable(
            state: state, kingPassing: [57, 58], emptySquares: [57, 58]);
        return isAvailable;
      }
    }
    return false;
  }

  bool isLongCastlingAvailable(ChessState state) {
    if (!state.check.isChecked &&
        !state.check.isDouble &&
        !state.longRookMoved &&
        !state.kingMoved) {
      if (state.isWhite) {
        final bool isAvailable = isCastlingAvailable(
            state: state, kingPassing: [58, 59], emptySquares: [57, 58, 59]);
        return isAvailable;
      } else {
        final bool isAvailable = isCastlingAvailable(
            state: state, kingPassing: [60, 61], emptySquares: [60, 61, 62]);
        return isAvailable;
      }
    }
    return false;
  }

  ChessState castleShort(ChessState state) {
    if (state.isWhite) {
      final castleState = castle(
        state: state,
        kingIndex: 60,
        rookIndex: 63,
        kingTo: 62,
        rookTo: 61,
      );
      return castleState;
    } else {
      final castleState = castle(
        state: state,
        kingIndex: 59,
        rookIndex: 56,
        kingTo: 57,
        rookTo: 58,
      );
      return castleState;
    }
  }

  ChessState castleLong(ChessState state) {
    if (state.isWhite) {
      final castleState = castle(
        state: state,
        kingIndex: 60,
        rookIndex: 56,
        kingTo: 58,
        rookTo: 59,
      );
      return castleState;
    } else {
      final castleState = castle(
        state: state,
        kingIndex: 59,
        rookIndex: 63,
        kingTo: 61,
        rookTo: 60,
      );
      return castleState;
    }
  }

  ChessState castle({
    required ChessState state,
    required int kingIndex,
    required int rookIndex,
    required int kingTo,
    required int rookTo,
  }) {
    // king index
    final king = state.squareContent[kingIndex].piece!;
    // Rook index
    final shortRook = state.squareContent[rookIndex].piece!;
    state.squareContent[kingIndex].piece = null;
    state.squareContent[rookIndex].piece = null;
    // king to
    // rook to

    state.squareContent[kingTo].piece = king;
    state.squareContent[rookTo].piece = shortRook;
    state.squareContent[kingIndex].squareColor = SquareColor.lightGreen;
    state.squareContent[rookIndex].squareColor = SquareColor.lightGreen;

    final move = MoveModel(
      // king index
      to: kingIndex,
      // rook index
      from: rookIndex,
      emptySquares: [kingIndex, rookIndex],
      movedPieces: [
        // king to
        MovedPiece(index: kingTo, name: Strings.king),
        // rook to
        MovedPiece(index: rookTo, name: Strings.rook),
      ],
    );

    return state.copyWith(
      check: const Check(),
      shortRookMoved: true,
      longRookMoved: true,
      isMyTurn: false,
      kingMoved: true,
      moveModel: move,
      // king to
      king: kingTo,
      from: -1,
    );
  }

  bool isCastlingAvailable({
    required ChessState state,
    required List<int> kingPassing,
    required List<int> emptySquares,
  }) {
    List<SquareContent> content = contentFrom(state.squareContent);
    // empty Squares.....
    bool areEmpty = true;
    for (int square in emptySquares) {
      if (state.squareContent[square].piece != null) {
        areEmpty = false;
      }
    }

    if (areEmpty) {
      // king passing squares.....
      final Check first = isSquareChecked(content, kingPassing[0]);
      final Check second = isSquareChecked(content, kingPassing[1]);
      if (first.isChecked == false &&
          second.isChecked == false &&
          first.isDouble == false &&
          second.isDouble == false) {
        return true;
      }
    }

    return false;
  }
}
