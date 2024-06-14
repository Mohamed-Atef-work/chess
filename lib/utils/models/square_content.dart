import 'package:chess/logic/pieces/piece.dart';

import '../enums/square_color.dart';

class SquareContent {
  bool mark;
  Piece? piece;
  SquareColor squareColor;
  SquareContent({
    this.piece,
    this.mark = false,
    this.squareColor = SquareColor.transParent,
  });
}
