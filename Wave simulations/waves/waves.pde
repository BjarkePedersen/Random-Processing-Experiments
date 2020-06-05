int size = 128;
int scale = 6;
float[][] vals = new float[size][size];
Cell[][] cells = new Cell[size][size];

Boolean allowNoise = true;

PShape square;

void setup() {
  background(25);
  surface.setSize(size*scale, size*scale);
  noStroke();
  fill(255);
 

  for (int x=0; x<size; x++) 
    for (int y=0; y<size; y++) {
      int[] ID = new int[2];
      ID[0] = x;
      ID[1] = y;

      cells[x][y] = new Cell(ID);
      vals[x][y] = 0;
    }

  square = createShape(RECT, 0, 0, scale, scale);
  
}

void drawImg() {
  for (Cell[] i : cells)
    for (Cell j : i) {
      j.show();
  }
}
void sharePos() {
  for (Cell[] i : cells)
    for (Cell j : i) {
      j.sharePos();
  }
}
void forces() {
  for (Cell[] i : cells)
    for (Cell j : i) {
      j.forces();
  } 
}
void physics() {
  for (Cell[] i : cells)
    for (Cell j : i) {
      j.physics();
  }
}

void mousePressed() {
  cells[round(mouseX/scale)][round(mouseY/scale)].y = 2;
}

void mouseDragged() {
  cells[
    constrain(round(mouseX/scale),1,width/scale-2)]
    [constrain(round(mouseY/scale),1,height/scale-2)].y = 0.2;
}



float t = 0;

void draw() {
  t++;
  frameRate(60);
  background(25);
  colorMode(HSB, 255);
  sharePos();
  forces();
  physics();
  drawImg();
  
}
