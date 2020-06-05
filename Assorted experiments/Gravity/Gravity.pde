

P[] ps = new P[100];

void setup() {
  size(800,800,P2D);
  pixelDensity(displayDensity());
  smooth(8);
  noStroke();
  //stroke(255,100,100);
  //colorMode(HSB);
  ellipseMode(CENTER);
  background(25);
    
  for (int i=0; i<ps.length; i++) {
    float mass = pow(randomGaussian(),3);
    mass = mass < 1 ? 1 : mass;
    //float mass = 1;
    ps[i] = new P(new PVector(random(width/6,width*5/6), random(height/6,height*5/6)), mass);
  }

}

void draw() {
  background(25);
  for (P p : ps) { p.forces(); p.move(); p.show();}
 
}