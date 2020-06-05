

//// COLORMODE  1: BW  2: RAINBOW
int colorMode = 1;

//// QUALITY: 1 / 2 / 3 
int quality = 2;

//// ps = particles
//// fs = forces

P[] ps = new P[100 * int(pow(10, quality))];
PVector[][] fs;
PGraphics pg;


void setup() {
  //size(800, 880, P2D);
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  background(0);
  noStroke();
  smooth(8);
  ellipseMode(CENTER);
  colorMode(HSB);

  for (int i=0; i<ps.length; i++) ps[i] = new P(
    new PVector(random(0, width), random(0, height)), 
    new PVector(0, 0));

  fs = new PVector[width][height];

  noiseSeed(1);
  for (int i=0; i<fs.length; i++)
    for (int j=0; j<fs[i].length; j++) {
      float fi = float(i);
      float fj = float(j);
      Float x = map((noise(fi/100, fj/100)), 0, 1, -1, 1);
      fs[i][j] = new PVector(x, 0);
    }
  noiseSeed(2);
  for (int i=0; i<fs.length; i++)
    for (int j=0; j<fs[i].length; j++) {
      float fi = float(i);
      float fj = float(j);
      Float y = map((noise(fi/100, fj/100)), 0, 1, -1, 1);
      fs[i][j].y = y;
    }
}


float bright = 0;

void draw() {
  if (colorMode == 1) { bright += .7; fill(bright); }
  if (colorMode == 2) { bright += .5; fill(color(bright, 255, 255)); println("woahh"); }


  for (P p : ps) { 
    p.applyForces(); 
    p.show();
  }
}

class P {
  PVector loc, vel, prevLoc;
  float thick;
  boolean show = true;

  public P(PVector loc, PVector vel) {
    this.loc = loc;
    this.vel = vel;
    
    if (quality == 3) { thick = random(0.1, 0.3); }
    if (quality == 2) { thick = random(1, 3); }
    if (quality == 1) { thick = random(2, 6); }
  }

  void applyForces() {
    int x = floor(loc.x);
    int y = floor(loc.y);
    if (x < width && x > 0 && y < height && y > 0) {
      PVector f = new PVector(
        fs[x][y].x, 
        fs[x][y].y
        );
      loc.add(f);
      show = true;
    } else show = false;
  }
  void show() {
    if (show) ellipse(loc.x, loc.y, thick, thick);
  }
}