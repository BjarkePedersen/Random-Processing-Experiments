int soloHighScore = 0;

void showScore() {
  fill(0);

  int i = 0;
  for (Player p : players) {
    i++;
    if (i == 1) {
      textAlign(LEFT);
      text(p.score, width/2 + hp(11), hp(13));
    } else {
      textAlign(RIGHT);
      text(p.score, width/2 - hp(11), hp(13));
    }
  }
  if (playerCount == 1) {
    textAlign(RIGHT);
    text(soloHighScore, width/2 - hp(11), hp(13));
  }
}

void countdown() {
  fill(255);
  textAlign(CENTER);
  int i = ceil(float(countdown)/60);
  text(i, width/2, height/2 + wp(2));
  countdown --;
}

int winCountdown = 120;
void showWinner() {
  if (winCountdown == 120) saveHighScore();
  fill(col1);
  textAlign(CENTER);
  if (playerCount == 2) text(winner == p2 ? "Left wins!" : "Right wins!", width/2, height/2 + wp(2));
  else if (winner == p2) text("Game over!", width/2, height/2 + wp(2)); 
  winCountdown--;
  if (winCountdown == 0) { 
    winner.score ++;
    if (playerCount == 1) { p1.score = 0;}
    winCountdown = 120; 
    winner = null;
    ball1 = new Ball(new PVector(width/2, height/2));
    pause = true;
    countdown = 180;

    p1.pos.y = height/2;
    p2.pos.y = height/2;
  }
}
