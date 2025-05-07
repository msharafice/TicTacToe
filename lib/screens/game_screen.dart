import 'package:flutter/material.dart';
// import '../widgets/score_board.dart';
import '../widgets/game_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // ScoreBoard(),
          SizedBox(height: 20),
          GameBoard(),
        ],
      ),
    );
  }
}
