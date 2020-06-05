
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
Boundary[] boundaries = new Boundary[4];
// A list for all of our rectangles
//ArrayList<Particle> particles;
int numPoints = 1000;
Particle[] particles = new Particle[numPoints];
int borderThickness = 10;
int bd = borderThickness;

void setup() {
  size(1366,768, P2D);
  pixelDensity(displayDensity());
  println("ENTER: release the gas");
  println("UP / DOWN: change temperature");
  colorMode(HSB);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);
  
  
   for(int i=0; i < numPoints; i++) {
      // Make a new particle
      Particle p = null;
      p = new Particle(random(bd, width - bd), random(bd,height - bd), 4,false);
      particles[i] = p;
   }
   

   for (Particle p : particles) {
     Vec2 force = new Vec2(random(-250,250),random(-250,250));
      p.applyForce(force);
    }

  // Add a bunch of fixed boundaries
  boundaries[0] = new Boundary(width/2,height-bd/2,width,bd);
  boundaries[1] = new Boundary(width/2,bd/2,width,bd);
  boundaries[2] = new Boundary(width-bd/2,height/2,bd,height);
  boundaries[3] = new Boundary(bd/2,height/2,bd,height);
}



float t = 0;

boolean boundary = true;

void keyPressed(){
  if (keyCode == ENTER) 
    try { 
      boundary = false; 
      boundaries[2].x = width + 100; 
      boundaries[2].killBoundary(); 
    } finally {;}
    
  if (keyCode == UP) increaseTemperature();
  if (keyCode == DOWN) decreaseTemperature();
}

void draw() {
  background(255);
    
  t++;
  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();
  box2d.step();
  
  if (boundary) {
    boundaries[2].killBoundary();
    boundaries[2] = new Boundary(width-bd/2-(sin(t/100-PI/2)+1)*400,height/2,bd,height);
  }
  
  for (Particle p: particles) {
      p.display();
    }

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
}

void increaseTemperature() {
  for (Particle p: particles) 
    p.setVelocity(1.2); }
    
void decreaseTemperature() {
  for (Particle p: particles) 
    p.setVelocity(.8); }
