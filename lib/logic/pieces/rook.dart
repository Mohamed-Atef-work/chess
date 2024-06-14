import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

class Rook extends Piece {
  Rook({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.rook,
    super.image = PiecesImages.rook,
  });

  @override
  ChessState move(ChessState state, int to) {
    if ((state.from == 63 && state.isWhite) ||
        (state.from == 56 && !state.isWhite)) {
      final newState = super.move(state, to);
      return newState.copyWith(shortRookMoved: true);
    } else if ((state.from == 56 && state.isWhite) ||
        (state.from == 63 && !state.isWhite)) {
      final newState = super.move(state, to);
      return newState.copyWith(longRookMoved: true);
    } else {
      return super.move(state, to);
    }
  }

  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    final piecesPositions =
        super.piecesPositionsFromContent(state.squareContent);
    final List<int> up = _goUp(piecesPositions, position);
    print("UP is -..........${up}");
    final List<int> down = _goDown(piecesPositions, position);
    print("down is -..........${down}");
    final List<int> right = _goRight(piecesPositions, position);
    print("right is -..........${right}");

    final List<int> left = _goLeft(piecesPositions, position);
    print("left is -..........${left}");

    List<int> available = up + down + right + left;

    return available;
  }

  List<int> _goUp(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];

    super.calcRowAndColumn(position);
    do {
      if (row != 1 && piecesPositions[position - 8] != true) {
        position -= 8;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }
    } while (true);
  }

  List<int> _goDown(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];

    super.calcRowAndColumn(position);
    do {
      if (row != 8 && piecesPositions[position + 8] != true) {
        position += 8;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }
    } while (true);
  }

  List<int> _goRight(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];

    super.calcRowAndColumn(position);
    do {
      if (column != 8 && piecesPositions[position + 1] != true) {
        position += 1;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }
    } while (true);
  }

  List<int> _goLeft(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];

    super.calcRowAndColumn(position);
    do {
      if (column != 1 && piecesPositions[position - 1] != true) {
        position -= 1;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }
    } while (true);
  }
}
