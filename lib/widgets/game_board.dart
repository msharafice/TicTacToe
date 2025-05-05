import 'package:flutter/material.dart';
import 'cell.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'O';

  void _handleTap(int index) {
    if (board[index] != '') return;

    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'O' ? 'X' : 'O';
    });

    // TODO: بررسی برنده
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Cell(
            value: board[index],
            onTap: () => _handleTap(index),
          );
        },
      ),
    );
  }
}
