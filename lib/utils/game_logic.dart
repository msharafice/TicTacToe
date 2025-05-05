class GameLogic {
  /// بررسی برنده شدن
  static String? checkWinner(List<String> board) {
    const winPatterns = [
      // ردیف‌ها
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      // ستون‌ها
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      // قطرها
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String first = board[pattern[0]];
      if (first != '' &&
          first == board[pattern[1]] &&
          first == board[pattern[2]]) {
        return first;
      }
    }

    return null; // برنده‌ای نیست
  }

  /// بررسی مساوی شدن
  static bool isDraw(List<String> board) {
    return !board.contains('') && checkWinner(board) == null;
  }

  /// ریست کردن برد
  static List<String> resetBoard() {
    return List.filled(9, '');
  }
}
