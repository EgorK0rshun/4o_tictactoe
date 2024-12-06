import 'dart:math';

class AI {
  final Random _random = Random();

  // Метод для получения хода бота
  Map<String, int> getMove(List<List<String?>> board) {
    List<Map<String, int>> availableMoves = [];

    // Собираем все свободные клетки
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == null) {
          availableMoves.add({'row': row, 'col': col});
        }
      }
    }

    // Выбираем случайный ход
    return availableMoves[_random.nextInt(availableMoves.length)];
  }
}
