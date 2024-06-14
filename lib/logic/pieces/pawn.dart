import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

class Pawn extends Piece {
  Pawn({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.pawn,
    super.image = PiecesImages.pawn,
  });

  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    final piecesPositions =
        super.piecesPositionsFromContent(state.squareContent);
    super.calcRowAndColumn(position);

    /// if checked || frontSquare [blocked] ================> empty
    /// if in firstMove && secondSquare isNot [blocked] ==========> two Squares
    /// ==========> frontSquare
    List<int> squares = [];
    if (column != 8 && piecesPositions[position - 7] == false) {
      squares.add(position - 7);
    }
    if (column != 1 && piecesPositions[position - 9] == false) {
      squares.add(position - 9);
    }
    if (piecesPositions[position - 8] == null) {
      squares.add(position - 8);
      if (row == 7 && piecesPositions[position - 16] == null) {
        squares.add(position - 16);
      }
    }
    return squares;
  }
}
