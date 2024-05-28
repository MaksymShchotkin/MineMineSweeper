class Cell {
  bool isMine;
  bool isRevealed;
  bool isFlagged; // Add this property
  int adjacentMines;

  Cell({this.isMine = false, this.isRevealed = false, this.isFlagged = false, this.adjacentMines = 0});
}
