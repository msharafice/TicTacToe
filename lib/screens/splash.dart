import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/screens/game_screen.dart';

class TicTacToeHomePage extends StatelessWidget {
  const TicTacToeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'TIC TAC TOE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: _BoardPainter(),
                  child: Stack(
                    children: [
                      _buildSymbol('O', 0, 0),
                      _buildSymbol('O', 1, 1),
                      _buildSymbol('O', 2, 0),
                      _buildSymbol('X', 0, 2),
                      _buildSymbol('X', 1, 2),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40), // فاصله بین برد و دکمه‌ها
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B2A82),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen()),
                    );
                  },
                  child: const Text(
                    'START GAME',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text(
                    'EXIT',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSymbol(String symbol, int row, int col) {
    return Positioned(
      top: row * 100.0,
      left: col * 100.0,
      width: 100,
      height: 100,
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            color: symbol == 'O' ? Colors.red : Colors.blue,
          ),
        ),
      ),
    );
  }
}

class _BoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..strokeWidth = 8;

    final thirdWidth = size.width / 3;
    final thirdHeight = size.height / 3;

    // Vertical lines
    canvas.drawLine(
        Offset(thirdWidth, 0), Offset(thirdWidth, size.height), paint);
    canvas.drawLine(
        Offset(thirdWidth * 2, 0), Offset(thirdWidth * 2, size.height), paint);

    // Horizontal lines
    canvas.drawLine(
        Offset(0, thirdHeight), Offset(size.width, thirdHeight), paint);
    canvas.drawLine(
        Offset(0, thirdHeight * 2), Offset(size.width, thirdHeight * 2), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
