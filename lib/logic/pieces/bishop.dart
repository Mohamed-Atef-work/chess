import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/constants/image_path.dart';
import 'package:chess/utils/constants/strings.dart';

class Bishop extends Piece {
  Bishop({
    required super.isWhite,
    required super.isMyPiece,
    super.name = Strings.bishop,
    super.image = PiecesImages.bishop,
  });

  @override
  List<int> ordinaryMoves(ChessState state, int position) {
    final piecesPositions =
        super.piecesPositionsFromContent(state.squareContent);
    final List<int> topRight = _topRight(piecesPositions, position);
    print("_topRight is -..........${topRight}");
    final List<int> topLeft = _topLeft(piecesPositions, position);
    print("_topLeft is -..........${topLeft}");
    final List<int> bottomRight = _bottomRight(piecesPositions, position);
    print("_bottomRight is -..........${bottomRight}");

    final List<int> bottomLeft = _bottomLeft(piecesPositions, position);
    print("_bottomLeft is -..........${bottomLeft}");

    List<int> available = topRight + topLeft + bottomRight + bottomLeft;

    return available;
  }

  List<int> _topRight(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];
    super.calcRowAndColumn(position);
    do {
      if (row != 1 && column != 8 && piecesPositions[position - 7] != true) {
        position -= 7;
        availableMoves.add(position);

        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }

      print("added position${position}");
    } while (true);
  }

  List<int> _topLeft(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];
    super.calcRowAndColumn(position);
    do {
      if (row != 1 && column != 1 && piecesPositions[position - 9] != true) {
        position -= 9;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }

      print("added position${position}");
    } while (true);
  }

  List<int> _bottomRight(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];
    super.calcRowAndColumn(position);
    do {
      if (row != 8 && column != 8 && piecesPositions[position + 9] != true) {
        position += 9;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }

      print("added position${position}");
    } while (true);
  }

  List<int> _bottomLeft(List<bool?> piecesPositions, int position) {
    List<int> availableMoves = [];

    super.calcRowAndColumn(position);
    do {
      if (row != 8 && column != 1 && piecesPositions[position + 7] != true) {
        position += 7;
        availableMoves.add(position);
        if (piecesPositions[position] == false) {
          return availableMoves;
        }
        super.calcRowAndColumn(position);
      } else {
        return availableMoves;
      }

      print("added position${position}");
    } while (true);
  }
}
