int size = 128;
int scale = 6;
float[][] vals = new float[size][size];
Cell[][] cells = new Cell[size][size];

float[][] accum = new float[size][size];

int[] wall1 = new int[4];

Boolean allowNoise = true;

PShape square;


void setup() {
  background(25);
  surface.setSize(size*scale, size*scale);
  noStroke();
  fill(255);
  
  colorMode(HSB, 255);
  

  for (int x=0; x<size; x++) 
    for (int y=0; y<size; y++) {
      int[] ID = new int[2];
      ID[0] = x;
      ID[1] = y;

      cells[x][y] = new Cell(ID);
      vals[x][y] = 0;
    }

  square = createShape(RECT, 0, 0, scale, scale);
  
  wall1[0] = 20;
  wall1[1] = 20;
  wall1[2] = 10;
  wall1[3] = 80;
  
  thread("mainThread");
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
    for (int j=0; j<wall1[3]; j++) {
      cells[wall1[0]+i][wall1[1]+j].y = 0;
    }
}

float freq = 1;
void sine() {
  cells[size/2][size/3].y = random(-1,1);
  cells[size/2+1][size/3+1].y = random(-1,1);
  cells[size/2+1][size/3].y = random(-1,1);
  cells[size/2][size/3+1].y = random(-1,1);
  
  cells[size/2+2][size/3].y = random(-1,1);
  cells[size/2+2][size/3+1].y = random(-1,1);
  cells[size/2+2][size/3+2].y = random(-1,1);
  cells[size/2+1][size/3+2].y = random(-1,1);
  cells[size/2][size/3+2].y = random(-1,1);
  
  //cells[size/2][1].y = sin(t*freq)*2;
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
  frameRate(60);
  drawImg();
}
