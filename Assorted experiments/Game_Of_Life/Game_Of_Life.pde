int size = 512;
int scale = 2;
int[][] img = new int[size][size];
int[][] result = new int[size][size];

Boolean allowNoise = true;

void setup() {
  background(25);
  
  importData();
  surface.setSize(size*scale, size*scale);
  
  noStroke();
  fill(255);
 
  makeNoise();
}

void drawImg() {
  for (int x=0; x<size; x++) {
    for (int y=0; y<size; y++) {
      if (img[x][y] == 1) {
        rect(scale*x, scale*y, scale, scale);
      }
    }
  }
}

void draw() {
  frameRate(60);
  background(25);
  applyRules();
  drawImg();
}

      