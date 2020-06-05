
int size1 = 128;
PVector[][] step1 = new PVector[size1][size1];

PImage out;

void setup() {
  size(1024,1024, P2D); 
  //pixelDensity(displayDensity());
  
  for (int i=0; i<size1; i++) {
    for (int j=0; j<size1; j++) {
      step1[i][j] = new PVector(random(-1,1), random(-1,1));
    }
  }
  
  out = createImage(width, height, RGB);
}

void draw() {
  background(0);
  int index = 0;
  int x = -1;
  int y = -1;
  
  for (int i=0; i<width; i++) {
    x = i % size1 == 0 ? x+1 : x;
    x = x % sqrt(size1) == 0 ? 0 : x;
    
    y = x % sqrt(size1) == 0 ? y+1 : y;
    
    for (int j=0; j<height; j++) {
      y = j % size1 == 0 ? y++ : y;
      PVector pixelLoc = new PVector(i,j);
      float val =(step1[x  ][y  ].mag() * step1[x  ][y  ].dist(pixelLoc) +
                  step1[x+1][y  ].mag() * step1[x+1][y  ].dist(pixelLoc) +
                  step1[x  ][y+1].mag() * step1[x  ][y+1].dist(pixelLoc) +
                  step1[x+1][y+1].mag() * step1[x+1][y+1].dist(pixelLoc)) / 4;
      
      index++;
      out.pixels[index-1] = color(val);
      out.updatePixels();
    }
  }
  image(out, 0,0);
  
  noFill();
  stroke(0);
  for (int i=0; i<size1; i++)
    for (int j=0; j<size1; j++)
      rect(i*size1,j*size1,size1,size1);
}