class Statistics {
  int xWins;
  int oWins;

  Statistics({this.xWins = 0, this.oWins = 0});

  void incrementXWins() {
    xWins++;
  }

  void incrementOWins() {
    oWins++;
  }
}
