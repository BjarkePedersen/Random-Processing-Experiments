// http://profs.etsmtl.ca/mmcguffin/research/fluidSimulator/
int gridSize = 64;
int gridScale = 12;

PVector[][] p = new PVector[gridSize][gridSize];
PVector[][] vx = new PVector[gridSize][gridSize];
PVector[][] vy = new PVector[gridSize][gridSize];

boolean friction = true;

void setup() {
  size(782, 782, P2D);
  pixelDensity(displayDensity());
  smooth();

  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      vx[x][y] = new PVector(random(-1,1), random(-1,1));
      vy[x][y] = new PVector(random(-1,1), random(-1,1));
      p[x][y] = new PVector(0,0);
    }
  }
}

void draw() {
  physics();
  background(25);
  noFill();
  stroke(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      //rect(x*gridScale, y*gridScale, gridScale, gridScale);
      line(
        x*gridScale + gridScale/2, 
        y*gridScale + gridScale/2, 
        x*gridScale + gridScale/2 + vx[x][y].x + vy[x][y].x, 
        y*gridScale + gridScale/2 + vx[x][y].y + vy[x][y].y);
    }
  }
}
