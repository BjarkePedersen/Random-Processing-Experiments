

void keyPressed() {
  if (!gameOver) {

    if (activePlayer == p1)
      if (key == 'a')
        activeColumn = activeColumn <= 0 ? 0 : activeColumn-1;
    if (activePlayer == p2)
      if (keyCode == LEFT)
        activeColumn = activeColumn <= 0 ? 0 : activeColumn-1;

    if (activePlayer == p1)
      if ( key == 'd') 
        activeColumn = activeColumn >= GW-1 ? GW-1 : activeColumn+1;
    if (activePlayer == p2)
      if (keyCode == RIGHT) 
        activeColumn = activeColumn >= GW-1 ? GW-1 : activeColumn+1;

    if (activePlayer == p1)
      if (key == 's') 
        place();
    if (activePlayer == p2)
      if (keyCode == DOWN) 
        place();
  }

  if (keyCode == ENTER) {
    playAgain();
  }
}