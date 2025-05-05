import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final String value;
  final VoidCallback onTap;

  const Cell({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    if (value == 'O') {
      color = Colors.red;
    } else if (value == 'X') {
      color = Colors.blue;
    } else {
      color = Colors.white24;
    }

    return GestureDetector(
      onTap: value == '' ? onTap : null,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
