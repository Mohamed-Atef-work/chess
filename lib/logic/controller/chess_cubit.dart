import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chess/data/repo.dart';
import 'package:chess/data/model.dart';
import 'package:chess/utils/enums/square_color.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/extensions/controller_helper.dart';
import 'package:chess/utils/models/check_model.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/models/square_content.dart';
import 'package:chess/utils/extensions/cubit_initial_extension.dart';

import '../../utils/constants/strings.dart';
import '../pieces/king.dart';

part 'chess_state.dart';

class ChessCubit extends Cubit<ChessState> {
  final ChessRepo _chessRepo = ChessRepoImpl();
  StreamSubscription<MoveModel>? opponentMovesStreamSubscription;

  ChessCubit() : super(const ChessState());

  void playWithWhite() {
    final whiteState = setAsWhite();
    emit(whiteState);
    _uploadMove();
    _movesStream();
  }

  void playWithBlack() {
    final blackState = setAsBlack();
    emit(blackState);
    _uploadMove();
    _movesStream();
  }

  void squareClicked(int index) {
    Piece? piece = state.squareContent[index].piece;



    if (state.isMyTurn) {
      if (piece != null && piece.isMyPiece) {
        _myPieceMoves(index);
      } else if (state.squareContent[index].mark == true) {
        /// move....
        _move(state.from, index);
        _uploadMove();
      }
    }
  }

  void _uploadMove() {
    String me;
    if (state.isWhite) {
      me = Strings.white;
    } else {
      me = Strings.black;
    }
    emit(state.copyWith(requestState: RequestState.loading));
    _chessRepo.uploadMove(state.moveModel, me).then((value) {
      emit(
        state.copyWith(requestState: RequestState.success),
      );
    }).catchError((error) {
      print("-------------------->${error.toString()}");
      emit(
        state.copyWith(
          message: error.toString(),
          requestState: RequestState.error,
        ),
      );
    });
  }

  void _movesStream() {
    String opponent;
    if (state.isWhite) {
      opponent = Strings.black;
    } else {
      opponent = Strings.white;
    }
    opponentMovesStreamSubscription?.cancel();
    opponentMovesStreamSubscription =
        _chessRepo.movesStream(opponent).listen((event) {
      _listen(event);
    });
  }

  void _listen(MoveModel move) {
    if (move.emptySquares.isNotEmpty && move.movedPieces.isNotEmpty) {
      Piece? pieceWasInTheToSquare = state.squareContent[move.to].piece;

      List<Piece> myEatenPieces = state.myEatenPieces;

      /// when opponent castles ....
      if (pieceWasInTheToSquare is Piece && pieceWasInTheToSquare is! King) {
        myEatenPieces = state.myEatenPieces + [pieceWasInTheToSquare];
      }

      for (var element in move.emptySquares) {
        state.squareContent[element].piece = null;
      }

      for (var element in move.movedPieces) {
        final piece = getPiece(name: element.name);
        state.squareContent[element.index].piece = piece;
      }

      /// coloring opponent moves....
      /// check if (king) Checked........

      final check = _listenHelper(move.from, move.to);

      emit(
        state.copyWith(
          check: check,
          isMyTurn: true,
          myEatenPieces: myEatenPieces,
          requestState: RequestState.success,
        ),
      );
    }
  }

  void _move(int from, int to) {
    removeRedGreen();
    removeMarks();
    final piece = state.squareContent[from].piece!;
    final newState = piece.move(state, to);
    emit(newState);
  }

  void _myPieceMoves(int index) {
    removeRedGreenAvailableMoves();
    emit(state.copyWith(from: index));
    final piece = state.squareContent[index].piece!;
    final availableMoves = piece.availableMoves(state, index);
    final selectedIndex = state.squareContent[index];
    if (selectedIndex.squareColor != SquareColor.red) {
      state.squareContent[index].squareColor = SquareColor.green;
    }

    mark(availableMoves);
  }

  Check _listenHelper(int from, to) {
    removeRedGreen();

    /// coloring opponent moves....
    state.squareContent[to].squareColor = SquareColor.lightGreen;
    state.squareContent[from].squareColor = SquareColor.lightGreen;

    final king = state.squareContent[state.king].piece;
    final check = king!.isSquareChecked(state.squareContent, state.king);

    /// check if (king) Checked........
    if (check.isDouble || check.isChecked) {
      state.squareContent[state.king].squareColor = SquareColor.red;
    }
    return check;
  }

  @override
  Future<void> close() {
    opponentMovesStreamSubscription?.cancel();
    return super.close();
  }
}
