import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.generate(9, (index) => ''); // شبکه 3x3
  String currentPlayer = 'X'; // شروع با X
  bool gameOver = false; // برای مشخص کردن وضعیت بازی
  String winner = ''; // برای ذخیره کردن برنده
  List<int> winningLine = []; // برای ذخیره کردن خانه‌های برنده

  void _handleTap(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        winner = _checkWinner();
        if (winner != '') {
          gameOver = true;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  // بررسی برنده و ذخیره خانه‌های برنده
  String _checkWinner() {
    // خطوط افقی
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] != '' &&
          board[i * 3] == board[i * 3 + 1] &&
          board[i * 3 + 2] == board[i * 3 + 1]) {
        winningLine = [
          i * 3,
          i * 3 + 1,
          i * 3 + 2
        ]; // ذخیره کردن خانه‌های برنده
        return 'row$i';
      }
    }

    // خطوط عمودی
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        winningLine = [i, i + 3, i + 6]; // ذخیره کردن خانه‌های برنده
        return 'col$i';
      }
    }

    // قطرها
    if (board[0] != '' && board[0] == board[4] && board[4] == board[8]) {
      winningLine = [0, 4, 8]; // ذخیره کردن خانه‌های برنده
      return 'diag1';
    }
    if (board[2] != '' && board[2] == board[4] && board[4] == board[6]) {
      winningLine = [2, 4, 6]; // ذخیره کردن خانه‌های برنده
      return 'diag2';
    }

    // بررسی مساوی
    if (!board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  // نمایش نتیجه بازی
  String _getResultMessage() {
    if (winner == 'Draw') {
      return 'Game Draw!';
    } else if (winner != '') {
      return '$currentPlayer Wins!';
    }
    return '$currentPlayer\'s Turn';
  }

  // دکمه برای شروع مجدد بازی
  void _restartGame() {
    setState(() {
      board = List.generate(9, (index) => '');
      currentPlayer = 'X';
      gameOver = false;
      winner = '';
      winningLine = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // نمایش نتیجه بازی
            Text(
              _getResultMessage(),
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // نمایش شبکه بازی
            Stack(
              alignment: Alignment.center,
              children: [
                // نمایش شبکه بازی
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _handleTap(index);
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            board[index],
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: board[index] == 'X'
                                  ? Colors.blue
                                  : (board[index] == 'O'
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // رسم خط برنده با CustomPainter
                if (winner != '' && winner != 'Draw')
                  CustomPaint(
                    size: Size(300, 300),
                    painter: LinePainter(winningLine),
                  ),
              ],
            ),
            SizedBox(height: 20),
            // دکمه برای شروع مجدد بازی
            ElevatedButton(
              onPressed: () {
                _restartGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // رنگ پس‌زمینه دکمه
                foregroundColor: Colors.black, // رنگ متن دکمه
              ),
              child: Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final List<int> winningLine;

  LinePainter(this.winningLine);

  @override
  void paint(Canvas canvas, Size size) {
    if (winningLine.isEmpty) return;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // مشخصات صفحه
    double gridSize = size.width / 3;

    // محاسبه موقعیت سه خانه برنده
    double x1 = (winningLine[0] % 3) * gridSize + gridSize / 2;
    double y1 = (winningLine[0] ~/ 3) * gridSize + gridSize / 2;

    double x2 = (winningLine[1] % 3) * gridSize + gridSize / 2;
    double y2 = (winningLine[1] ~/ 3) * gridSize + gridSize / 2;

    double x3 = (winningLine[2] % 3) * gridSize + gridSize / 2;
    double y3 = (winningLine[2] ~/ 3) * gridSize + gridSize / 2;

    // رسم خط از اولین خانه به دومین خانه و از دومین به سومین خانه
    canvas.drawLine(Offset(x1, y1), Offset(x3, y3), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
