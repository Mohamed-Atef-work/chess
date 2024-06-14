part of 'chess_cubit.dart';

class ChessState {
  final int from;
  final int king;
  final Check check;
  final bool isWhite;
  final bool isMyTurn;
  final String message;
  final bool kingMoved;
  final bool longRookMoved;
  final bool shortRookMoved;
  final MoveModel moveModel;
  final RequestState requestState;
  final List<Piece> myEatenPieces;
  final List<Piece> opponentEatenPieces;
  final List<SquareContent> squareContent;

  const ChessState({
    this.from = -1,
    this.king = 60,
    this.message = "",
    this.isWhite = true,
    this.isMyTurn = false,
    this.kingMoved = false,
    this.check = const Check(),
    this.longRookMoved = false,
    this.shortRookMoved = false,
    this.myEatenPieces = const [],
    this.squareContent = const [],
    this.moveModel = const MoveModel(),
    this.opponentEatenPieces = const [],
    this.requestState = RequestState.initial,
  });

  ChessState copyWith({
    int? from,
    int? king,
    Check? check,
    bool? isWhite,
    bool? isMyTurn,
    String? message,
    bool? kingMoved,
    bool? longRookMoved,
    bool? shortRookMoved,
    MoveModel? moveModel,
    RequestState? requestState,
    List<Piece>? myEatenPieces,
    List<Piece>? opponentEatenPieces,
    List<SquareContent>? squareContent,
  }) =>
      ChessState(
        from: from ?? this.from,
        king: king ?? this.king,
        check: check ?? this.check,
        message: message ?? this.message,
        isWhite: isWhite ?? this.isWhite,
        isMyTurn: isMyTurn ?? this.isMyTurn,
        moveModel: moveModel ?? this.moveModel,
        kingMoved: kingMoved ?? this.kingMoved,
        requestState: requestState ?? this.requestState,
        squareContent: squareContent ?? this.squareContent,
        longRookMoved: longRookMoved ?? this.longRookMoved,
        myEatenPieces: myEatenPieces ?? this.myEatenPieces,
        shortRookMoved: shortRookMoved ?? this.shortRookMoved,
        opponentEatenPieces: opponentEatenPieces ?? this.opponentEatenPieces,
      );
}
