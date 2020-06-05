import java.awt.Color;

boolean displayForces = true;
boolean displayGrid = true;
boolean displayParticles = false;

PGraphics pg;

P[] particles = new P[1024];
PShape particleShape;

PVector[][] forces;

void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  pg = createGraphics(width, height);
  fill(255);
  noStroke();

  initializeForces();

  // Create particles
  for (int p=0; p<particles.length; p++) {
    float locX = random(0, width);
    float locY = random(0, height);

    particles[p] = new P(locX, locY);
  }

  particleShape = createShape(ELLIPSE, 0, 0, 5, 5);
  
  
  println("ENTER: Toggle forces");
  println("DELETE: Toggle grid");
  println("BACKSPACE: Toggle particles");
}

void keyPressed() {
  if (key == ENTER) {displayForces = !displayForces;}
  if (key == BACKSPACE) {displayParticles = !displayParticles;}
  if (key == DELETE) {displayGrid = !displayGrid;}
}

void draw() {
  background(25);
  
  if (displayForces) { showForces(); }
  
  noStroke();
  if (displayParticles) {
    for (P p : particles) {
      p.move();
      p.velX *= 0.99;  // damp
      p.velY *= 0.99;
      p.show();
    }
  }
}