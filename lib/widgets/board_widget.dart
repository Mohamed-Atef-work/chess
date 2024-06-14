import 'package:chess/logic/controller/chess_cubit.dart';
import 'package:chess/widgets/squares_content_widget.dart';
import 'package:chess/widgets/squares_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ChessCubit()..playWithWhite(),
      child: BlocBuilder<ChessCubit, ChessState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.myEatenPieces.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: List.generate(
                      state.myEatenPieces.length,
                      (index) => SvgPicture.asset(
                        width: 30,
                        height: 30,
                        state.myEatenPieces[index].image,
                        color: state.myEatenPieces[index].color,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 5,
                child: state.requestState == RequestState.loading
                    ? const LinearProgressIndicator()
                    : null,
              ),
              Container(
                width: width,
                height: width,
                margin: const EdgeInsets.all(5), //  to it's child from it ...
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      SquaresWidget(),
                      SquaresContentWidget(),
                    ],
                  ),
                ),
              ),
              if (state.opponentEatenPieces.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: List.generate(
                      state.opponentEatenPieces.length,
                      (index) => SvgPicture.asset(
                        width: 30,
                        height: 30,
                        state.opponentEatenPieces[index].image,
                        color: state.opponentEatenPieces[index].color,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () {
                        BlocProvider.of<ChessCubit>(context).playWithWhite();
                      },
                      text: "Play as White",
                      fontSize: 18,
                      width: width * 0.4,
                      height: 40,
                    ),
                    CustomButton(
                      onPressed: () {
                        BlocProvider.of<ChessCubit>(context).playWithBlack();
                      },
                      text: "Play as Black",
                      width: width * 0.4,
                      fontSize: 18,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
