class GameLogic {
  List<List<String?>> board;
  String currentPlayer;
  String? winner;

  GameLogic()
      : board = List.generate(3, (_) => List.generate(3, (_) => null)),
        currentPlayer = 'X',
        winner = null;

  // Игровая логика, смена игрока и проверка победы
  void playMove(int row, int col) {
    if (board[row][col] != null || winner != null) return;

    board[row][col] = currentPlayer;
    if (checkWin(row, col)) {
      winner = currentPlayer;
    } else if (board.every((row) => row.every((cell) => cell != null))) {
      winner = 'N'; // Ничья
    } else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  // Проверка на победу
  bool checkWin(int row, int col) {
    // Проверка строки
    if (board[row].every((cell) => cell == currentPlayer)) return true;

    // Проверка столбца
    if (board.every((r) => r[col] == currentPlayer)) return true;

    // Проверка диагоналей
    if (row == col && board.every((r) => r[r.indexOf(r)] == currentPlayer)) return true;
    if (row + col == 2 && board.every((r) => r[2 - r.indexOf(r)] == currentPlayer)) return true;

    return false;
  }

  // Сброс игры
  void resetBoard() {
    board = List.generate(3, (_) => List.generate(3, (_) => null));
    currentPlayer = 'X';
    winner = null;
  }

  // Проверка завершения игры
  bool isGameOver() => winner != null;

  String getCurrentPlayer() => currentPlayer;
}
