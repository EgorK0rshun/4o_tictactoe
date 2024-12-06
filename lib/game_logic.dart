class GameLogic {
  // Доска для игры
  List<List<String?>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null],
  ];

  // Текущий игрок (X или O)
  String currentPlayer = 'X';

  // Победитель
  String? winner;

  // Метод для обработки хода игрока
  void playMove(int row, int col) {
    // Проверяем, что ячейка пуста
    if (board[row][col] == null && winner == null) {
      board[row][col] = currentPlayer;
      // Меняем текущего игрока после хода
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }

    // Проверка победителя после каждого хода
    winner = _checkWinner();
  }

  // Метод для сброса доски
  void resetBoard() {
    board = [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];
    winner = null;
    currentPlayer = 'X';
  }

  // Проверка на победу
  String? _checkWinner() {
    // Проверяем строки, столбцы и диагонали
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null && board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
        return board[i][0];
      }
      if (board[0][i] != null && board[0][i] == board[1][i] && board[0][i] == board[2][i]) {
        return board[0][i];
      }
    }

    if (board[0][0] != null && board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
      return board[0][0];
    }
    if (board[0][2] != null && board[0][2] == board[1][1] && board[0][2] == board[2][0]) {
      return board[0][2];
    }

    // Если нет победителя, проверяем ничью
    if (_isBoardFull()) {
      return 'DRAW';
    }

    return null;
  }

  // Проверка, заполнена ли доска
  bool _isBoardFull() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == null) {
          return false;
        }
      }
    }
    return true;
  }

  // Метод для проверки, завершена ли игра
  bool isGameOver() {
    return winner != null;
  }
}
