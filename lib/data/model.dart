import 'package:chess/utils/constants/strings.dart';

class MoveModel {
  final int to;
  final int from;
  final List<int> emptySquares;
  final List<MovedPiece> movedPieces;
  const MoveModel({
    this.to = 0,
    this.from = 0,
    this.movedPieces = const [],
    this.emptySquares = const [],
  });
  factory MoveModel.fromJson(Map<String, dynamic> json) => MoveModel(
        to: revers(json[Strings.to]),
        from: revers(json[Strings.from]),
        emptySquares: List<int>.from(json[Strings.emptySquares])
            .map((e) => revers(e))
            .toList(),
        movedPieces: List.from(json[Strings.movedPieces])
            .map((e) => MovedPiece.fromJson(e))
            .toList(),
      );
  Map<String, dynamic> toMap() => {
        Strings.to: to,
        Strings.from: from,
        Strings.emptySquares: emptySquares,
        Strings.movedPieces: List.generate(
            movedPieces.length, (index) => movedPieces[index].toMap()),
      };
}

class MovedPiece {
  final int index;
  final String name;

  const MovedPiece({
    this.index = 0,
    this.name = "null",
  });

  factory MovedPiece.fromJson(Map<String, dynamic> json) => MovedPiece(
        index: revers(json[Strings.index]),
        name: json[Strings.name],
      );

  Map<String, dynamic> toMap() => {
        Strings.index: index,
        Strings.name: name,
      };
}

int revers(int position) {
  int column = position % 8;
  int row = position ~/ 8;

  column = 7 - column;

  row = 7 - row;

  final newPosition = row * 8 + column;
  return newPosition;
}

final map = {
  "to": 0,
  "from": 0,
  "emptySquares": [1, 2],
  "movedPieces": [
    {
      "index": 3,
      "name": "R",
    },
    {
      "index": 4,
      "name": "K",
    },
  ],
};
