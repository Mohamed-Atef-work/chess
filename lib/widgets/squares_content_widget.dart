import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/logic/pieces/bishop.dart';
import 'package:chess/logic/pieces/king.dart';
import 'package:chess/logic/pieces/night.dart';
import 'package:chess/logic/pieces/piece.dart';
import 'package:chess/logic/pieces/queen.dart';
import 'package:chess/logic/pieces/rook.dart';
import 'package:chess/utils/constants/colors.dart';
import 'package:chess/utils/enums/square_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SquaresContentWidget extends StatelessWidget {
  const SquaresContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ChessCubit, ChessState>(
      builder: (context, state) {
        return Wrap(
          direction: Axis.horizontal,
          children: List.generate(
            64,
            (index) => SquareContent(
              index: index,
              width: width,
              mark: state.squareContent[index].mark,
              squareColor: state.squareContent[index].squareColor,
              pieceImage: state.squareContent[index].piece?.image,
              pieceColor: state.squareContent[index].piece?.color,
            ),
          ),
        );
      },
    );
  }
}

class SquareContent extends StatelessWidget {
  final bool mark;
  final int index;
  final double width;
  final SquareColor squareColor;
  final Color? pieceColor;
  final String? pieceImage;

  const SquareContent({
    super.key,
    this.pieceImage,
    this.pieceColor,
    required this.mark,
    required this.index,
    required this.width,
    this.squareColor = SquareColor.transParent,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ChessCubit>(context);
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ChessCubit>(context).squareClicked(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: squareColor == SquareColor.lightGreen
              ? lightGreen.withOpacity(0.7)
              : squareColor == SquareColor.green
                  ? green.withOpacity(0.6)
                  : Colors.transparent,
          border: Border.all(
            color: squareColor == SquareColor.lightGreen
                ? Colors.grey
                : Colors.transparent,
          ),
        ),
        width: (width - 5 - 15 - 15 - 5) / 8,
        height: (width - 15 - 15) / 8,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: (width - 15 - 15) / 8,
              width: (width - 5 - 15 - 15 - 5) / 8,
            ),
            if (pieceImage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: squareColor == SquareColor.red
                        ? [
                            const BoxShadow(
                              color: redCheck,
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: SvgPicture.asset(
                    pieceImage!,
                    width: (width - 5 - 15 - 15 - 5 - 100) /
                        _pieceSize(controller.state.squareContent[index].piece!)
                            .width,
                    height: (width - 15 - 15 - 100) /
                        _pieceSize(controller.state.squareContent[index].piece!)
                            .height,
                    color: pieceColor,
                  ),
                ),
              ),
            if (mark == true)
              const Center(
                child: CircleAvatar(
                  maxRadius: 8,
                  backgroundColor: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

PieceSize _pieceSize(Piece piece) {
  if (piece is King || piece is Queen) {
    return PieceSize(3, 7.5);
  } else if (piece is Rook) {
    return PieceSize(3, 9);
  } else if (piece is Bishop) {
    return PieceSize(3, 8);
  } else if (piece is Night) {
    return PieceSize(3, 9);
  } else {
    return PieceSize(3, 10);
  }
}

class PieceSize {
  final double width;
  final double height;

  PieceSize(this.width, this.height);
}
