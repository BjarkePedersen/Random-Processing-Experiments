

P[] ps = new P[1000];

void setup() {
  size(800,800,P2D);
  //fullScreen(P2D);
  pixelDensity(displayDensity());
  smooth(8);
  stroke(255);
  ellipseMode(CENTER);
  background(25);
    
  for (int i=0; i<ps.length; i++) {
    // Make circle pls
    ps[i] = new P(new PVector(width/2 + random(-100,100), height/2 + random(-100,100)), 1);
  }
  
  thread("thread1");
  thread("thread2");
  
  thread("controlThread");

}

int t1 = 0;
int t2 = 0;
int step = 0;

void draw() {
  background(25);
  for (P p : ps) {p.show(); }
}