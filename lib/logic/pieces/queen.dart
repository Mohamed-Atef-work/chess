import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/bishop.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/logic/pieces/rook.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

class Queen extends Piece {
  final Piece bishop = Bishop(isMyPiece: true, isWhite: true);
  final Piece rook = Rook(isMyPiece: true, isWhite: true);

  Queen({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.queen,
    super.image = PiecesImages.queen,
  });
  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    final List<int> rookSquares = rook.ordinaryMoves(state, position);
    final List<int> bishopSquares = bishop.ordinaryMoves(state, position);
    return rookSquares + bishopSquares;
  }
}
