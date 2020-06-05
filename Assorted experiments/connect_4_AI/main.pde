

void keyPressed() {
  if (!gameOver) {

    //if (activePlayer == p1)
    //  if (key == 'a')
    //    activeColumn = activeColumn <= 0 ? 0 : activeColumn-1;
    if (activePlayer == p2)
      if (keyCode == LEFT)
        activeColumn = activeColumn <= 0 ? 0 : activeColumn-1;

    //if (activePlayer == p1)
    //  if ( key == 'd') 
    //    activeColumn = activeColumn >= GW-1 ? GW-1 : activeColumn+1;
    if (activePlayer == p2)
      if (keyCode == RIGHT) 
        activeColumn = activeColumn >= GW-1 ? GW-1 : activeColumn+1;

    //if (activePlayer == p1)
    //  if (key == 's') 
    //    place();
    if (activePlayer == p2)
      if (keyCode == DOWN) 
        place();
  }

  if (keyCode == ENTER) {
    playAgain();
  }

  if (keyCode == BACKSPACE) {
    stop = true;
  }

  if (keyCode == 32) {
    viewWeights = !viewWeights;
  }

  if (key == 'p') {
    viewPlayer1 = !viewPlayer1;
  }
}

boolean auto = true;
boolean random = true;
boolean stop = false;


void thread1() {
  int trainTime = 3000000;
  int j = 0;
  for (int i=0; i<trainTime; i++) {
    j ++;
    if (stop) break;
    if (j >= 10000) {
      j = 0; 
      println(float(i)/trainTime*100, "%");
    }
    if (activePlayer == p1) {
      AI1.think();
      activeColumn = getChoice(AI1.getOutput());
      while (!checkPlaceable()) {
        int choice = getChoice(AI1.getOutput());
        AI1.neurons[AI1.neurons.length-1][choice] = -9999;
        activeColumn = choice;
      }
    }
    if (activePlayer == p2) {
      if (random) activeColumn = floor(random(0, GW));
      else {
        AI2.think();
        activeColumn = getChoice(AI2.getOutput());
        while (!checkPlaceable()) {
          int choice = getChoice(AI2.getOutput());
          AI2.neurons[AI2.neurons.length-1][choice] = -9999;
          activeColumn = choice;
        }
      }
    }
    if (j % 10 == 0) random = !random;


    place();
    checkWinner();
  }
  auto = false;

  if (!auto) {
    AIplacement();
  }
}

void AIplacement() {
  if (activePlayer == p1) {
    AI1.think();
    activeColumn = getChoice(AI1.getOutput());
    while (!checkPlaceable()) {
      int choice = getChoice(AI1.getOutput());
      AI1.neurons[AI1.neurons.length-1][choice] = -9999;
      activeColumn = choice;
    }
    place();
    checkWinner();
  }
}
