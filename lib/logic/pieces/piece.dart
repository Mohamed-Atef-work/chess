import 'package:chess/data/model.dart';
import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/utils/extensions/moves_extinsion.dart';
import 'package:chess/utils/models/check_model.dart';
import 'package:flutter/material.dart';

import '../../utils/enums/square_color.dart';
import '../../utils/models/square_content.dart';

abstract class Piece {
  final String name;
  final String image;
  final bool isWhite;
  final bool isMyPiece;

  late final Color color;
  late int column;
  late int row;

  Piece({
    required this.name,
    required this.image,
    required this.isWhite,
    required this.isMyPiece,
  }) {
    _pieceColor();
  }

  List<int> availableMoves(ChessState state, int position) {
    if (state.check.isDouble) {
      return const [];
    } else {
      // There is a check or not ......
      // will add moves that don't make a (check).
      final ordinary = ordinaryMoves(state, position);
      print("ordinary moves -----------------------------------> $ordinary");
      final removingCheck = movesRemovingCheck(
        ordinaryAvailable: ordinary,
        moveFrom: position,
        state: state,
      );
      return removingCheck;
    }
  }

  List<int> ordinaryMoves(ChessState state, int position);

  ChessState move(ChessState state, int to) {
    final pieceWasInTheTo = state.squareContent[to].piece;
    final pieceWasInTheFrom = state.squareContent[state.from].piece!;
    List<Piece> opponentEatenPieces = state.opponentEatenPieces;

    /// isWhite -------------> means : are you white or black NOT the [piece];

    print(
        "state.isWhite ----------------------------------------------> ${state.isWhite}");
    print(
        "pieceWasInTheTo.isWhite ----------------------------------------------> ${pieceWasInTheTo?.isWhite}");
    if (pieceWasInTheTo != null) {
      opponentEatenPieces = opponentEatenPieces + [pieceWasInTheTo];
    }

    state.squareContent[state.from].piece = null;
    state.squareContent[to].piece = pieceWasInTheFrom;

    /// coloring my moves....
    state.squareContent[state.from].squareColor = SquareColor.lightGreen;
    state.squareContent[to].squareColor = SquareColor.lightGreen;

    final move = MoveModel(
      to: to,
      from: state.from,
      emptySquares: [state.from],
      movedPieces: [MovedPiece(index: to, name: pieceWasInTheFrom.name)],
    );

    print(" --------------------------------> ${state.moveModel.emptySquares}");
    return state.copyWith(
      opponentEatenPieces: opponentEatenPieces,
      check: const Check(),
      moveModel: move,
      isMyTurn: false,
      from: -1,
    );
  }

  List<bool?> piecesPositionsFromContent(List<SquareContent> squareContent) {
    List<bool?> positions = [];
    squareContent.map((e) {
      if (e.piece != null) {
        positions.add(e.piece!.isMyPiece);
      } else {
        positions.add(null);
      }
    }).toList();
    return positions;
  }

  void calcRowAndColumn(int position) {
    column = position % 8 + 1;
    row = position ~/ 8 + 1;
  }

  void _pieceColor() {
    if (isMyPiece) {
      if (isWhite) {
        color = Colors.white;
      } else {
        color = Colors.black;
      }
    } else {
      if (isWhite) {
        color = Colors.black;
      } else {
        color = Colors.white;
      }
    }
  }
}
