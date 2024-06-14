import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class SquaresWidget extends StatelessWidget {
  const SquaresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(64, (index) => _square(index, width)),
    );
  }

  _square(int index, double width) => Container(
        color: _colors[index],
        width: (width - 5 - 15 - 15 - 5) / 8,
        height: (width - 15 - 15) / 8,
      );
}

final List<Color> _colors =
    _first + _second + _first + _second + _first + _second + _first + _second;

final List<Color> _first = _base + [darkBrown];

final List<Color> _second = [darkBrown] + _base;

final List<Color> _smallBase = [darkWhite, darkBrown];

final List<Color> _base = _smallBase + _smallBase + _smallBase + [darkWhite];
