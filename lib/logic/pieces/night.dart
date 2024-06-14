import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

class Night extends Piece {
  Night({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.night,
    super.image = PiecesImages.night,
  });

  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    final piecesPositions =
        super.piecesPositionsFromContent(state.squareContent);
    super.calcRowAndColumn(position);

    List<int> availableSquares = [];
    if (row >= 3 && column <= 7 && piecesPositions[position - 15] != true) {
      availableSquares.add(position - 15);
    }
    if (row <= 6 && column >= 2 && piecesPositions[position + 15] != true) {
      availableSquares.add(position + 15);
    }
    if (row >= 2 && column <= 6 && piecesPositions[position - 6] != true) {
      availableSquares.add(position - 6);
    }
    if (row <= 7 && column >= 3 && piecesPositions[position + 6] != true) {
      availableSquares.add(position + 6);
    }
    if (row >= 3 && column >= 2 && piecesPositions[position - 17] != true) {
      availableSquares.add(position - 17);
    }
    if (row <= 6 && column <= 7 && piecesPositions[position + 17] != true) {
      availableSquares.add(position + 17);
    }
    if (row >= 2 && column >= 3 && piecesPositions[position - 10] != true) {
      availableSquares.add(position - 10);
    }
    if (row <= 7 && column <= 6 && piecesPositions[position + 10] != true) {
      availableSquares.add(position + 10);
    }

    return availableSquares;
  }
}
