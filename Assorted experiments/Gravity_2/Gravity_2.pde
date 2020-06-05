

P[] ps = new P[2000];

void setup() {
  //size(800,800,P2D);
  fullScreen(P2D);
  pixelDensity(displayDensity());
  smooth(8);
  stroke(255);
  ellipseMode(CENTER);
  background(25);
    
  for (int i=0; i<ps.length; i++) {
    // Make circle pls
    ps[i] = new P(new PVector(width/2 + random(-200,200), height/2 + random(-200,200)), 1);
  }
  
  thread("t1");

}

void draw() {
  background(25);
  
  //if (true) {
  //  noStroke();
  //  colorMode(HSB);
  //  for (int i=0; i<width/20; i++)
  //    for (int j=0; j<height/20; j++) {
  //      float d = 0;
  //      for (P p : ps) { 
  //        PVector f = new PVector(p.loc.x - i*20, p.loc.y - j*20);
  //        d += abs(f.mag());
  //      }
  //      fill(color(255 /  (1 + pow(2.78,-d/200000 )),255,255));
  //      rect(i*20, j*20, 20, 20);
  //    }
  //  colorMode(RGB);
  //  stroke(0);
  //}
  
  for (P p : ps) {p.show(); }
}
