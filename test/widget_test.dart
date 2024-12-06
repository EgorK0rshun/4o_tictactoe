// import 'package:flutter_test/flutter_test.dart';
// import 'package:o4_tictactoe/ai.dart';
//
// import 'package:o4_tictactoe/game_logic.dart';
//
// void main() {
//   group('GameLogic', () {
//     test('Проверка победы по горизонтали', () {
//       var game = GameLogic();
//       game.playMove(0, 0);
//       game.playMove(1, 0);
//       game.playMove(0, 1);
//       game.playMove(1, 1);
//       game.playMove(0, 2);
//       expect(game.winner, 'X');
//     });
//
//     test('Проверка ничьей', () {
//       var game = GameLogic();
//       game.playMove(0, 0);
//       game.playMove(0, 1);
//       game.playMove(0, 2);
//       game.playMove(1, 0);
//       game.playMove(1, 1);
//       game.playMove(1, 2);
//       game.playMove(2, 0);
//       game.playMove(2, 1);
//       game.playMove(2, 2);
//       expect(game.winner, 'N');
//     });
//   });
//
//   group('AI', () {
//     test('AI должен выбирать ход', () {
//       var ai = AI();
//       var board = [
//         [null, null, null],
//         [null, null, null],
//         [null, null, null],
//       ];
//       var move = ai.getMove(board);
//       expect(move.containsKey('row'), true);
//       expect(move.containsKey('col'), true);
//     });
//   });
// }
