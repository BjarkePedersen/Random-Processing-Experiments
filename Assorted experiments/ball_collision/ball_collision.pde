
void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  ellipseMode(CENTER);

  noStroke();
  fill(255);

  for (int i=0; i<particles.length; i++) {
    particles[i] = new Particle(new PVector( random(0, width), random(0, height) ));
  }

  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      grid[i][j] = new ArrayList<Particle>();
    }
  }
}

void draw() {
  background(25);

  if (keyPressed) {
    if (keyCode == LEFT) {
      gx = -9.82;
    }
    if (keyCode == RIGHT) {
      gx = 9.82;
    }
  } else {
    gy = 9.82;
    gx = 0;
  }

  pushToGrid();
  for (Particle p : particles) p.forces();
  for (Particle p : particles) p.move();
  for (Particle p : particles) p.show();
}
