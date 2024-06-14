import 'package:chess/data/model.dart';
import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/bishop.dart';
import 'package:chess/logic/pieces/king.dart';
import 'package:chess/logic/pieces/night.dart';
import 'package:chess/logic/pieces/pawn.dart';
import 'package:chess/logic/pieces/queen.dart';
import 'package:chess/logic/pieces/rook.dart';

import '../models/square_content.dart';

extension Initial on ChessCubit {
  ChessState setAsWhite() {
    MoveModel move = const MoveModel();

    /// isWhite -------------> means : are you white or black NOT the [piece];
    final empty = List.generate(32, (index) => SquareContent());
    final opponentBig = _bigPieces(isWhite: true, isMyPiece: false);
    final opponentPawns = _pawns(isWhite: true, isMyPiece: false);
    final myBig = _bigPieces(isWhite: true, isMyPiece: true);
    final myPawns = _pawns(isWhite: true, isMyPiece: true);
    final board = opponentBig + opponentPawns + empty + myPawns + myBig;
    return state.copyWith(
      opponentEatenPieces: const [],
      myEatenPieces: const [],
      shortRookMoved: false,
      squareContent: board,
      longRookMoved: false,
      kingMoved: false,
      moveModel: move,
      isMyTurn: true,
      isWhite: true,
      king: 60,
    );
  }

  ChessState setAsBlack() {
    MoveModel move = const MoveModel();

    final empty = List.generate(32, (index) => SquareContent());
    final opponentBig = _bigPieces(isWhite: false, isMyPiece: false);
    final opponentPawns = _pawns(isWhite: false, isMyPiece: false);
    final myBig = _bigPieces(isWhite: false, isMyPiece: true);
    final myPawns = _pawns(isWhite: false, isMyPiece: true);
    final board = opponentBig + opponentPawns + empty + myPawns + myBig;
    return state.copyWith(
      opponentEatenPieces: const [],
      myEatenPieces: const [],
      shortRookMoved: false,
      longRookMoved: false,
      squareContent: board,
      kingMoved: false,
      moveModel: move,
      isMyTurn: false,
      isWhite: false,
      king: 59,
    );
  }

  List<SquareContent> _bigPieces({
    required bool isMyPiece,
    required bool isWhite,
  }) {
    final kingQueenOrder = kingQueen(isWhite: isWhite, isMyPiece: isMyPiece);
    return [
      SquareContent(piece: Rook(isWhite: isWhite, isMyPiece: isMyPiece)),
      SquareContent(piece: Night(isWhite: isWhite, isMyPiece: isMyPiece)),
      SquareContent(piece: Bishop(isWhite: isWhite, isMyPiece: isMyPiece)),
      kingQueenOrder[0],
      kingQueenOrder[1],
      SquareContent(piece: Bishop(isWhite: isWhite, isMyPiece: isMyPiece)),
      SquareContent(piece: Night(isWhite: isWhite, isMyPiece: isMyPiece)),
      SquareContent(piece: Rook(isWhite: isWhite, isMyPiece: isMyPiece)),
    ];
  }

  List<SquareContent> _pawns({
    required bool isMyPiece,
    required bool isWhite,
  }) =>
      List.generate(
        8,
        (index) => SquareContent(
          piece: Pawn(
            isMyPiece: isMyPiece,
            isWhite: isWhite,
          ),
        ),
      );
  List<SquareContent> kingQueen({
    required bool isMyPiece,
    required bool isWhite,
  }) {
    if (isWhite) {
      return [
        SquareContent(piece: Queen(isWhite: isWhite, isMyPiece: isMyPiece)),
        SquareContent(piece: King(isWhite: isWhite, isMyPiece: isMyPiece)),
      ];
    } else {
      return [
        SquareContent(piece: King(isWhite: isWhite, isMyPiece: isMyPiece)),
        SquareContent(piece: Queen(isWhite: isWhite, isMyPiece: isMyPiece)),
      ];
    }
  }
}
