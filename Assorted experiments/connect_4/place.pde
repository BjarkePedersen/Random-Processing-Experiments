
int activeColumn = round(GW/2);
Player activePlayer = random(0, 1) > 0.5 ? p1 : p2;

void place() {
  updateDrawGrid();

  int[] placement = new int[2];
  placement[0] = activeColumn;
  boolean placed = true;
  for (int i=0; i<GH; i++) { 
    if ( drawGrid[activeColumn][i] && i==0) placed = false;
    if ( !drawGrid[activeColumn][i] ) placement[1] = i;
  }

  if (placed) {
    activePlayer.grid[placement[0]][placement[1]] = true;
    updateDrawGrid();
    activePlayer = activePlayer == p1 ? p2 : p1;
  }
}

void updateDrawGrid() {
  for (int i=0; i<GW; i++) {
    for (int j=0; j<GH; j++) {
      drawGrid[i][j] = p1.grid[i][j] ? true : drawGrid[i][j];
      drawGrid[i][j] = p2.grid[i][j] ? true : drawGrid[i][j];
    }
  }
}

void showPlacement() { 
  float offsetY = (width - showScale * GW) / 2;
  noStroke();
  if (activePlayer == p1) fill(p1Color);
  else fill(p2Color);
  ellipse(activeColumn*showScale + offsetY, showScale, showScale, showScale);
}