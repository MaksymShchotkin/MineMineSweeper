import 'package:flutter/material.dart';
import '../models/cell.dart';
import '../models/minesweeper_game.dart';
import '../widgets/cell_widget.dart';
import 'game_over_screen.dart';

class MinesweeperScreen extends StatefulWidget {
  final int rows;
  final int columns;
  final int numMines;

  MinesweeperScreen({
    required this.rows,
    required this.columns,
    required this.numMines,
  });

  @override
  _MinesweeperScreenState createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  late MinesweeperGame game;
  bool isFlagMode = false;

  @override
  void initState() {
    super.initState();
    game = MinesweeperGame(rows: widget.rows, columns: widget.columns, numMines: widget.numMines);
  }

  @override
  Widget build(BuildContext context) {
    if (game.isGameOver) {
      // Calculate the score (number of mines disarmed)
      int score = game.calculateScore();
      Future.microtask(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameOverScreen(isWon: game.isWon, score: score),
        ),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Minesweeper'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFlagMode = false;
                  });
                },
                child: Text('Reveal Mode'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFlagMode ? Colors.grey : Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFlagMode = true;
                  });
                },
                child: Text('Flag Mode'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFlagMode ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: game.columns,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ game.columns;
                int col = index % game.columns;
                Cell cell = game.board[row][col];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFlagMode) {
                        cell.isFlagged = !cell.isFlagged;
                      } else {
                        game.revealCell(row, col);
                      }
                    });
                  },
                  child: CellWidget(cell: cell),
                );
              },
              itemCount: game.rows * game.columns,
            ),
          ),
        ],
      ),
    );
  }
}
