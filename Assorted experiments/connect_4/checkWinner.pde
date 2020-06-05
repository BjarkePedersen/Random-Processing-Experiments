Player winner;

boolean gameOver = false;

void checkWinner() {
  for (int i=0; i<GW; i++)
    for (int j=0; j<GH; j++) {
      checkHorizontal(p1, i, j);
      checkHorizontal(p2, i, j);
      checkVertical(p1, i, j);
      checkVertical(p2, i, j);
      checkDiagonal(p1, i, j);
      checkDiagonal(p2, i, j);
      checkDiagonal2(p1, i, j);
      checkDiagonal2(p2, i, j);
    }
  checkDraw();

}

void checkHorizontal(Player player, int i, int j) {
  int count = 0;
  boolean[][] winningBricks = new boolean[GW][GH];
  for (int k=0; k<4; k++) {
    if (i < 3 ) { 
      break;
    }
    if (player.grid[i-k][j]) { 
      count++; 
      winningBricks[i-k][j] = true;
    }
  }

  if ( count == 4 ) {
    win(player, winningBricks);
  }
}

void checkVertical(Player player, int i, int j) {
  int count = 0;
  boolean[][] winningBricks = new boolean[GW][GH];
  for (int k=0; k<4; k++) {
    if (j < 3 ) { 
      break;
    }
    if (player.grid[i][j-k]) { 
      count++; 
      winningBricks[i][j-k] = true;
    }
  }

  if ( count == 4 ) {
    win(player, winningBricks);
  }
}

void checkDiagonal(Player player, int i, int j) {
  int count = 0;
  boolean[][] winningBricks = new boolean[GW][GH];
  for (int k=0; k<4; k++) {
    if (j < 3 || i < 3 ) { 
      break;
    }
    if (player.grid[i-k][j-k]) { 
      count++; 
      winningBricks[i-k][j-k] = true;
    }
  }

  if ( count == 4 ) {
    win(player, winningBricks);
  }
}

void checkDiagonal2(Player player, int i, int j) {
  int count = 0;
  boolean[][] winningBricks = new boolean[GW][GH];
  for (int k=0; k<4; k++) {
    if (j < 3 || i > GW-4 ) { 
      break;
    }
    if (player.grid[i+k][j-k]) { 
      count++; 
      winningBricks[i+k][j-k] = true;
    }
  }

  if ( count == 4 ) {
    win(player, winningBricks);
  }
}

void checkDraw() {
  int count = 0;
  for (int i=0; i<GW; i++)
    for (int j=0; j<GH; j++) {
      if (drawGrid[i][j]) count++;
    }
  if (count == GW*GH) {
    gameOver = true;
    fill(255);
    textAlign(CENTER);
    text("Draw!", width/2, 40);
    text("Press ENTER to play again", width/2, height-40);
  }
}

void win(Player player, boolean[][] winningBricks) {
  if (!gameOver) player.score++;
  gameOver = true;
  winner = player;
  showWinner(winningBricks);
}


void playAgain() {
  winner = null;
  p1.grid = new boolean[GW][GH];
  p2.grid = new boolean[GW][GH];
  drawGrid = new boolean[GW][GH];
  activePlayer = random(0, 1) > 0.4864 ? p1 : p2;
  activeColumn = round(GW/2);
  gameOver = false;
}