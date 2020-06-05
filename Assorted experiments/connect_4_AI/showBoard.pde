int border1 = 20;
int border2 = 5;

color p1Color = color(200, 20, 20); 
color p2Color = color(240, 240, 50);

void showBoard() {
  noStroke();
  int showScale = 75;
  float offsetX = (height - showScale * GH) / 2;
  float offsetY = (width/2 - showScale * GW) / 2;

  fill(10, 70, 200);
  rect(offsetY-border1, offsetX-border1, width/2-offsetY*2+border1*2, height-offsetX*2+border1*2, 20, 20, 0, 0);
  for (int i=0; i<GW; i++)
    for (int j=0; j<GH; j++) {
      fill(25);
      ellipse(i*showScale + offsetY + border2, j*showScale + offsetX + border2, showScale-border2*2, showScale-border2*2);

      if (p1.grid[i][j]) { 
        fill(p1Color); 
        ellipse(i*showScale + offsetY + border2, j*showScale + offsetX + border2, showScale-border2*2, showScale-border2*2);
      }
      if (p2.grid[i][j]) { 
        fill(p2Color); 
        ellipse(i*showScale + offsetY + border2, j*showScale + offsetX + border2, showScale-border2*2, showScale-border2*2);
      }
    }

  showPlacement();

  textAlign(LEFT, TOP);
  fill(p1Color);
  text(p1.score, 20, 20);

  textAlign(RIGHT, TOP);
  fill(p2Color);
  text(p2.score, width/2-40, 20);
}

void showWinner(boolean[][] winningBricks) {
  if (winner == p1) fill(p1Color);
  if (winner == p2) fill(p2Color);

  textAlign(CENTER);
  text((winner == p1 ? "Red" : "Yellow") + " wins!", width/4, 40);

  fill(255);
  text("Press ENTER to play again", width/4, height-40);


  noFill();
  stroke(20, 250, 20);
  strokeWeight(5);
  float offsetX = (height - showScale * GH) / 2;
  float offsetY = (width/2 - showScale * GW) / 2;
  for (int i=0; i<GW; i++)
    for (int j=0; j<GH; j++) {
      if (winningBricks[i][j]) { 
        ellipse(i*showScale + offsetY + border2, j*showScale + offsetX + border2, showScale-border2*2, showScale-border2*2);
      }
    }
}