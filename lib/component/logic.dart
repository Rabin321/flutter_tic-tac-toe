class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static final length = 9; //3*3 rows and columns
  static final blocksize = 100.0;

  List<String>? board;
  List<String>? get initGameBoard =>
      List.generate(length, (index) => Player.empty);

  bool checkWinner(String player, int index, List<int> score, int gridSize) {
    int row = index ~/ 3;
    int col = index ~/ 3;
    int scoredata = player == "X" ? 1 : -1;

    score[row] += scoredata;
    score[gridSize + col] += scoredata;
    if (row == col) {
      score[2 * gridSize] += scoredata;
    }
    if (gridSize - 1 - col == row) {
      score[2 * gridSize + 1] += scoredata;
    }

    if (score.contains(3) || score.contains(-3)) {
      return true;
    }

    return false;
  }
}
