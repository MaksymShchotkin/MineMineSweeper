import 'package:flutter/material.dart';
import '../models/cell.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;

  const CellWidget({Key? key, required this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.0),
      color: cell.isRevealed ? Colors.white : Colors.blue, // Change revealed cells to white
      child: Center(
        child: Text(
          cell.isRevealed
              ? (cell.isMine ? 'M' : (cell.adjacentMines > 0 ? '${cell.adjacentMines}' : ''))
              : (cell.isFlagged ? 'F' : ''),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
