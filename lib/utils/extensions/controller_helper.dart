import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/enums/square_color.dart';

import '../../logic/pieces/bishop.dart';
import '../../logic/pieces/king.dart';
import '../../logic/pieces/night.dart';
import '../../logic/pieces/pawn.dart';
import '../../logic/pieces/queen.dart';
import '../../logic/pieces/rook.dart';
import '../constants/strings.dart';

extension ChessHelper on ChessCubit {
  void removeMarks() {
    state.squareContent.map((e) => e.mark = false).toList();
  }

  void removeRedGreen() {
    state.squareContent
        .map((e) => e.squareColor = SquareColor.transParent)
        .toList();
  }

  void removeRedGreenAvailableMoves() {
    state.squareContent.map((e) {
      if (e.squareColor != SquareColor.red) {
        e.squareColor = SquareColor.transParent;
      }
    }).toList();
  }

  void mark(List<int> squares) {
    removeMarks();
    squares.map((e) {
      state.squareContent[e].mark = true;
    }).toList();
  }

  Piece getPiece({required String name}) {
    final bool isWhite = state.isWhite;
    switch (name) {
      case Strings.pawn:
        return Pawn(isWhite: isWhite, isMyPiece: false);
      case Strings.night:
        return Night(isWhite: isWhite, isMyPiece: false);
      case Strings.bishop:
        return Bishop(isWhite: isWhite, isMyPiece: false);
      case Strings.queen:
        return Queen(isWhite: isWhite, isMyPiece: false);
      case Strings.rook:
        return Rook(isWhite: isWhite, isMyPiece: false);
      default:
        return King(isWhite: isWhite, isMyPiece: false);
    }
  }
}
