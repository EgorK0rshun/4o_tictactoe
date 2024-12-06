import 'dart:math';
enum Difficulty { easy, medium, hard }
class AI {
  final Random _random = Random();

  // Сложность игры

  Difficulty difficulty;

  // Конструктор AI с выбором сложности
  AI({this.difficulty = Difficulty.easy});

  // Метод для получения хода бота
  Map<String, int> getMove(List<List<String?>> board) {
  switch (difficulty) {
  case Difficulty.easy:
  return _getRandomMove(board);
  case Difficulty.medium:
  return _getMinimaxMove(board, 2);  // Средняя сложность
  case Difficulty.hard:
  return _getMinimaxMove(board, 9);  // Высокая сложность
  default:
  return _getRandomMove(board);
  }
  }

  // Метод для случайного хода (легкая сложность)
  Map<String, int> _getRandomMove(List<List<String?>> board) {
  List<Map<String, int>> availableMoves = [];

  for (int row = 0; row < 3; row++) {
  for (int col = 0; col < 3; col++) {
  if (board[row][col] == null) {
  availableMoves.add({'row': row, 'col': col});
  }
  }
  }

  return availableMoves[_random.nextInt(availableMoves.length)];
  }

  // Минимакс для вычисления хода в зависимости от сложности
  Map<String, int> _getMinimaxMove(List<List<String?>> board, int depth) {
  int bestScore = -9999;
  Map<String, int> bestMove = {};

  for (int row = 0; row < 3; row++) {
  for (int col = 0; col < 3; col++) {
  if (board[row][col] == null) {
  board[row][col] = 'O';
  int score = _minimax(board, depth - 1, false);
  board[row][col] = null;

  if (score > bestScore) {
  bestScore = score;
  bestMove = {'row': row, 'col': col};
  }
  }
  }
  }

  return bestMove;
  }

  // Алгоритм Минимакс для оценки ходов
  int _minimax(List<List<String?>> board, int depth, bool isMaximizing) {
  String? winner = _checkWinner(board);
  if (winner == 'X') return -1;
  if (winner == 'O') return 1;
  if (depth == 0 || _isBoardFull(board)) return 0;

  if (isMaximizing) {
  int bestScore = -9999;
  for (int row = 0; row < 3; row++) {
  for (int col = 0; col < 3; col++) {
  if (board[row][col] == null) {
  board[row][col] = 'O';
  int score = _minimax(board, depth - 1, false);
  board[row][col] = null;
  bestScore = max(score, bestScore);
  }
  }
  }
  return bestScore;
  } else {
  int bestScore = 9999;
  for (int row = 0; row < 3; row++) {
  for (int col = 0; col < 3; col++) {
  if (board[row][col] == null) {
  board[row][col] = 'X';
  int score = _minimax(board, depth - 1, true);
  board[row][col] = null;
  bestScore = min(score, bestScore);
  }
  }
  }
  return bestScore;
  }
  }

  // Проверка победителя
  String? _checkWinner(List<List<String?>> board) {
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

  return null;
  }

  // Проверка, заполнена ли доска
  bool _isBoardFull(List<List<String?>> board) {
  for (int row = 0; row < 3; row++) {
  for (int col = 0; col < 3; col++) {
  if (board[row][col] == null) {
  return false;
  }
  }
  }
  return true;
  }
}
