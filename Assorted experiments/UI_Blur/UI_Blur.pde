
int scale = 5;  // Downsize factor for faster blurring (Higher = faster, lower quality)
int blurSize = 25;  // Blur size
int style = 1; // UI style. 1 = frosted glass  2 = macOS window 
int w, h;

PImage img;
PGraphics pg, fullRes;

void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  noFill();
  stroke(230);

  scale *= displayDensity();
  blurSize *= displayDensity();
  blurSize /= scale;
  w = width / scale;
  h = height / scale;

  pg = createGraphics(width, height);
}

float i = 0;

void drawMain() {
  pg.beginDraw();
  pg.background(25);

  pg.noStroke();
  pg.fill(255, 100, 100);
  pg.rotate(sin(i/20)/10);
  pg.rect(100, 200, 300, 70, 25, 25, 25, 25);
  pg.rotate(-sin(i/20)/10);

  pg.fill(100, 200, 0);
  pg.ellipse(250, 600, 120, 200);

  pg.fill(255);
  pg.ellipse(600, 200, 600, 600);

  pg.rect(600, 200, 600, 600);

  pg.fill(0, 100, 255);
  pg.ellipse(sin(i/20)*20 + 600, 200, 200, 100);

  pg.endDraw();
}

void blurRegion(int x, int y, int wi, int hi) {
  int s = displayDensity(); 
  PImage blurImg = pg.get(x * s, y * s, wi * s, hi * s);
  PGraphics blurGraphics = createGraphics(wi / scale, hi / scale);
  wi /= scale;
  hi /= scale;
  // Downsize and blur the region
  blurImg.resize(wi, hi);
  blurImg.filter(BLUR, blurSize);

  // Color correct the blurred region
  for (int i=0; i<blurImg.pixels.length; i++) {
    color col = blurImg.pixels[i];
    if (style == 1) col = lerpColor(col, color(230, 230, 230), 0.3);
    if (style == 2) col = lerpColor(col, color(240, 240, 240), 0.8);
    blurImg.pixels[i] = col;
  }
  blurImg.updatePixels();
  
  wi *= scale;
  hi *= scale;
  image(blurImg, x, y, wi, hi);
}

void draw() {
  i++;
  drawMain();
  image(pg, 0, 0);

  blurRegion(mouseX, mouseY, 400, 200);
  rect(mouseX, mouseY, 400, 200);

  println(frameRate);
}
