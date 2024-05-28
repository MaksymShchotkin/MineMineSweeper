import 'dart:math';
import 'cell.dart';

class MinesweeperGame {
  final int rows;
  final int columns;
  final int numMines;
  late List<List<Cell>> board;
  bool isGameOver = false;
  bool isWon = false;

  MinesweeperGame({required this.rows, required this.columns, required this.numMines}) {
    board = List.generate(rows, (r) => List.generate(columns, (c) => Cell()));
    _placeMines();
    _calculateAdjacentMines();
  }

  void _placeMines() {
    int minesPlaced = 0;
    while (minesPlaced < numMines) {
      int row = Random().nextInt(rows);
      int col = Random().nextInt(columns);
      if (!board[row][col].isMine) {
        board[row][col].isMine = true;
        minesPlaced++;
      }
    }
  }

  void _calculateAdjacentMines() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        if (!board[row][col].isMine) {
          int count = 0;
          for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
              int newRow = row + i;
              int newCol = col + j;
              if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < columns && board[newRow][newCol].isMine) {
                count++;
              }
            }
          }
          board[row][col].adjacentMines = count;
        }
      }
    }
  }
  int calculateScore() {
    int disarmedMines = 0;
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        Cell cell = board[row][col];
        if (cell.isFlagged && cell.isMine) {
          disarmedMines++;
        }
      }
    }
    return disarmedMines;
  }

  void revealCell(int row, int col) {
    if (isGameOver || row < 0 || row >= rows || col < 0 || col >= columns || board[row][col].isRevealed || board[row][col].isFlagged) {
      return;
    }

    board[row][col].isRevealed = true;

    if (board[row][col].isMine) {
      isGameOver = true;
      isWon = false;
      return;
    }

    if (board[row][col].adjacentMines == 0) {
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          if (i != 0 || j != 0) {
            revealCell(row + i, col + j);
          }
        }
      }
    }

    _checkWin();
  }

  void _checkWin() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        if (!board[row][col].isMine && !board[row][col].isRevealed) {
          return;
        }
      }
    }
    isGameOver = true;
    isWon = true;
  }
}
