import 'package:flutter/material.dart';
import 'game_logic.dart';
import 'statistics.dart';
import 'ai.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Крестики-Нолики',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  GameLogic gameLogic = GameLogic();
  Statistics statistics = Statistics();
  AI ai = AI();
  bool isBotEnabled = false; // Флаг для активации бота

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Крестики-Нолики'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStatistics(),
          _buildGameBoard(),
          _buildGameStatus(),
          _buildBotToggle(),
        ],
      ),
    );
  }

  // Строим статистику игры (победы и поражения)
  Widget _buildStatistics() {
    return Column(
      children: [
        Text('Победы крестиков: ${statistics.xWins}'),
        Text('Победы ноликов: ${statistics.oWins}'),
      ],
    );
  }

  // Строим игровое поле
  Widget _buildGameBoard() {
    return Column(
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return _buildCell(row, col);
          }),
        );
      }),
    );
  }

  // Строим одну ячейку поля
  Widget _buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => _onCellTapped(row, col),
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.blue[50],
        ),
        child: Center(
          child: Text(
            gameLogic.board[row][col] ?? '',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  // Обработка клика по ячейке
  void _onCellTapped(int row, int col) {
    if (gameLogic.board[row][col] != null || gameLogic.isGameOver()) return;

    setState(() {
      gameLogic.playMove(row, col);
      if (gameLogic.isGameOver()) {
        _updateStatistics();
      } else if (isBotEnabled && gameLogic.currentPlayer == 'O') {
        _botMove();
      }
    });
  }

  // Обновление статистики после завершения игры
  void _updateStatistics() {
    setState(() {
      if (gameLogic.winner == 'X') {
        statistics.incrementXWins();
      } else if (gameLogic.winner == 'O') {
        statistics.incrementOWins();
      }
    });
  }

  // Сброс игры
  void _resetGame() {
    setState(() {
      gameLogic.resetBoard();
    });
  }

  // Статус игры (выиграл кто-то или ничья)
  Widget _buildGameStatus() {
    if (gameLogic.isGameOver()) {
      if (gameLogic.winner != null) {
        return Text('Победил: ${gameLogic.winner}', style: TextStyle(fontSize: 20, color: Colors.green));
      } else {
        return Text('Ничья!', style: TextStyle(fontSize: 20, color: Colors.orange));
      }
    }
    return Text('Ход игрока: ${gameLogic.currentPlayer}', style: TextStyle(fontSize: 20));
  }

  // Переключение включения бота
  Widget _buildBotToggle() {
    return SwitchListTile(
      title: Text('Играть с ботом'),
      value: isBotEnabled,
      onChanged: (bool value) {
        setState(() {
          isBotEnabled = value;
          gameLogic.resetBoard();
        });
      },
    );
  }

  // Ход бота
  void _botMove() {
    Future.delayed(Duration(milliseconds: 500), () {
      var move = ai.getMove(gameLogic.board);
      setState(() {
        gameLogic.playMove(move['row'], move['col']);
        if (gameLogic.isGameOver()) {
          _updateStatistics();
        }
      });
    });
  }
}
