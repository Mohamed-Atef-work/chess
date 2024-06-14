import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/utils/extensions/check_extension.dart';
import 'package:chess/utils/models/square_content.dart';

extension Move on Piece {
  List<int> movesRemovingCheck({
    required int moveFrom,
    required ChessState state,
    required List<int> ordinaryAvailable,
  }) {
    List<int> removingCheck = [];
    List<SquareContent> content = contentFrom(state.squareContent);

    final piece = content[moveFrom].piece!;

    for (int moveTo in ordinaryAvailable) {
      /// move ..............
      content[moveFrom].piece = null;
      content[moveTo].piece = piece;
      //
      final check = isSquareChecked(content, state.king);

      if (!check.isChecked && !check.isDouble) {
        print("[$moveTo] will not cause a check");
        removingCheck.add(moveTo);
        print(
            "available moves removing check length ----------> ${removingCheck.length}");
      }

      content = contentFrom(state.squareContent);
    }
    return removingCheck;
  }
}
