import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/splash.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TicTacToeHomePage(),
    );
  }
}
