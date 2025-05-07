import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/splash.dart';
import '../utils/game_logic.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'O';
  int scoreO = 0;
  int scoreX = 0;
  String? winner;

  void _handleTap(int index) {
    if (board[index] != '' || winner != null) return;

    setState(() {
      board[index] = currentPlayer;
      winner = GameLogic.checkWinner(board);

      if (winner != null) {
        if (winner == 'O') scoreO++;
        if (winner == 'X') scoreX++;
        _showDialog('Winner is $winner!');
      } else if (GameLogic.isDraw(board)) {
        _showDialog("It's a draw!");
      } else {
        currentPlayer = currentPlayer == 'O' ? 'X' : 'O';
      }
    });
  }

  void _resetBoard() {
    setState(() {
      board = GameLogic.resetBoard();
      winner = null;
      currentPlayer = 'O';
    });
  }

  void _showDialog(String message) {
    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    });
  }

  void _navigateBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const TicTacToeHomePage()), // Navigate back to the home page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // نمایش امتیاز و نوبت
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _playerBox('Player O', scoreO, Colors.red),
            _playerBox('Player X', scoreX, Colors.blue),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          winner != null ? 'Winner is $winner' : 'Turn $currentPlayer',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          height: 300,
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: board[index] == 'O'
                            ? Colors.red
                            : board[index] == 'X'
                                ? Colors.blue
                                : Colors.white24,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _resetBoard,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset Game'),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back to Home'),
        )
      ],
    );
  }

  Widget _playerBox(String name, int score, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(name, style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(height: 4),
        Text(score.toString(), style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
