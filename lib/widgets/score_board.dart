import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // این مقادیر در آینده باید از state یا provider بیاد
    final int scoreO = 0;
    final int scoreX = 0;
    final String turn = 'O';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _playerBox('Player O', scoreO, Colors.red),
            _playerBox('Player X', scoreX, Colors.blue),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Turn $turn',
          style: const TextStyle(fontSize: 20),
        ),
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
