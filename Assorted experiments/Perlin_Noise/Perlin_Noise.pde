PImage img;
float sc = 0.01;
float z = 0;

void setup() {
  size(400, 400);
  noSmooth();
  img = createImage(width, height, RGB);
}

void drawNoise() {
  img.loadPixels();
  int x = 0;
  int y = 0;
  for (int i = 0; i < img.pixels.length; i++) {
    x++;
    if (i % width == 0) {y++; x=0;}
    
    img.pixels[i] = color(
      noise(x*sc, y*sc, z*sc)*255, 
      noise(x*sc, y*sc, z*sc*.75+100)*255, 
      noise(x*sc, y*sc, z*sc*.5+200)*255);
  }
  img.updatePixels();
  image(img, 0, 0);
  z++;
}

void draw() {
  drawNoise();
}