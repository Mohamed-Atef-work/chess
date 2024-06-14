import 'package:flutter/material.dart';

import '../widgets/board_widget.dart';

class ChessScreen extends StatelessWidget {
  const ChessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BoardWidget(),
    );
  }
}
