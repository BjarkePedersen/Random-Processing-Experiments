int size = 128;
int scale = 6;
float[][] vals = new float[size][size];
Cell[][] cells = new Cell[size][size];

int[] wall1 = new int[4];
int[] wall2 = new int[4];
int[] wall3 = new int[4];

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
  
  wall1[0] = 0;
  wall1[1] = 50;
  wall1[2] = 55;
  wall1[3] = 1;
  
  wall2[0] = 128-55;
  wall2[1] = 50;
  wall2[2] = 55;
  wall2[3] = 1;
  
  wall3[0] = 56;
  wall3[1] = 50;
  wall3[2] = 16;
  wall3[3] = 1;
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
  for (int i=0; i<wall1[2]; i++) 
    for (int j=0; j<wall1[3]; j++) 
      cells[wall1[0]+i][wall1[1]+j].y = 0;
    
  for (int i=0; i<wall2[2]; i++) 
    for (int j=0; j<wall2[3]; j++) 
      cells[wall2[0]+i][wall2[1]+j].y = 0;
  
  for (int i=0; i<wall3[2]; i++) 
    for (int j=0; j<wall3[3]; j++) 
      cells[wall3[0]+i][wall3[1]+j].y = 0;
    
}

float freq = 1;
void sine() {
  cells[size/2][1].y = sin(t*freq)*4;
}

void changeFrequency() {
  if (keyPressed) {
    if (keyCode == UP)
      freq += 0.003;
      println("frequency: ", freq);
    if (keyCode == DOWN)
      freq -= 0.003;
      println("frequency: ", freq);
  }
      
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
  changeFrequency();
  sine();
}
