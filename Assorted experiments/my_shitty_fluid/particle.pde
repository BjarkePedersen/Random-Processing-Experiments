Particle[] particles = new Particle[5000];

float gy = 9.82;
float gx = 0;

int repelSize = 20;
int gridWidth = repelSize*2;
int gridHeight = repelSize*2;

float repelStrength = 0.1;
float damping = 0.99;
int repelExponent = -3;

ArrayList<Particle>[][] grid = (ArrayList<Particle>[][]) new ArrayList[gridWidth][gridHeight];

class Particle {
  PVector pos, prevPos, vel, acceleration;

  int gridIndex_i;
  int gridIndex_j;

  public Particle(PVector pos) {
    this.pos = pos;
    this.prevPos = pos;

    vel = new PVector(0, 0);
  }

  void move() {
    vel.y += gy/100;
    vel.x += gx/100;
    vel.add(acceleration);
    vel.mult(damping);
    pos.add(vel);

    collideBound();

    prevPos = pos;
  }


  void forces() {
    acceleration = new PVector(0, 0);
    // Kernel
    for (int i=-1; i<=1; i++) {
      for (int j=-1; j<=1; j++) {
        if (gridIndex_i+i >= 0 && gridIndex_i+i < gridWidth ) {
          if (gridIndex_j+j >= 0 && gridIndex_j+j < gridHeight) {
            for (Particle p : grid[gridIndex_i+i][gridIndex_j+j]) {

              if (p != this) {
                float distance = pos.dist(p.pos);
                if (distance < repelSize) {
                  float magnitude = - distance + repelSize;
                  //float magnitude = ( pow(distance,repelExponent) * 1000 );
                  magnitude = magnitude > 0 ? magnitude : 0;
                  //float eh = 1.1;
                  //magnitude = distance > repelSize * eh ? ( - distance + repelSize * eh ) /2 : magnitude;
                  //magnitude = distance > repelSize * eh + repelSize/2 ? 0 : magnitude;
                  magnitude *= -1 * repelStrength;
                  PVector direction = new PVector(p.pos.x - pos.x, p.pos.y - pos.y);
                  direction.normalize();
                  acceleration.add(direction.mult(magnitude / 2));
                }
              }
            }
          }
        }
      }
    }

    //for (Particle p : particles) {
    //  if (p != this) {
    //    float distance = pos.dist(p.pos);
    //    if (distance < repelSize) {
    //      float magnitude = - distance + repelSize;
    //      //float magnitude = ( pow(distance,repelExponent) * 1000 );
    //      magnitude = magnitude > 0 ? magnitude : 0;
    //      //float eh = 1.1;
    //      //magnitude = distance > repelSize * eh ? ( - distance + repelSize * eh ) /2 : magnitude;
    //      //magnitude = distance > repelSize * eh + repelSize/2 ? 0 : magnitude;
    //      magnitude *= -1 * repelStrength;
    //      PVector direction = new PVector(p.pos.x - pos.x, p.pos.y - pos.y);
    //      direction.normalize();
    //      acceleration.add(direction.mult(magnitude / 2));
    //    }
    //  }
    //}
    //println(pos.x, pos.y);
    // Repel bounding box
    if (pos.y > height - repelSize || pos.y < repelSize ) {
      float distance = pos.y > height / 2 ? height - pos.y  : pos.y ;
      if (distance < repelSize) {
        float magnitude = - distance + repelSize;
        //float magnitude = ( pow(distance,repelExponent) / 1000000 );
        magnitude = magnitude > 0 ? magnitude : 0;
        magnitude *= - 1 * repelStrength;
        PVector direction = new PVector( 0, pos.y > height / 2 ? 1 : -1);
        direction.normalize();
        acceleration.add(direction.mult(magnitude));
      }
    }
    if (pos.x > width - repelSize || pos.x < repelSize ) {
      float distance = pos.x > width / 2 ? width - pos.x  : pos.x ;
      if (distance < repelSize) {
        float magnitude = - distance + repelSize;
        //float magnitude = ( pow(distance,repelExponent) / 1000000 );
        magnitude = magnitude > 0 ? magnitude : 0;
        magnitude /= 2;
        magnitude *= - 1 * repelStrength;
        PVector direction = new PVector( pos.x > width / 2 ? 1 : -1, 0);
        direction.normalize();
        acceleration.add(direction.mult(magnitude));
      }
    }
  }

  void collideBound() {
    if (pos.y > height || pos.y < 0 ) {
      vel.y *= -1;
      pos.y = pos.y > height / 2 ? height : 0;
    }
    if (pos.x > width || pos.x < 0 ) {
      vel.x *= -1;
      pos.x = pos.x > width / 2 ? width : 0;
    }
  }

  void show() {
    ellipse(pos.x, pos.y, 5, 5);
  }
}


void pushToGrid() {
  int cellWidth = (width/gridWidth+1);
  int cellHeight = (height/gridHeight+1);

  // Clear list
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[i].length; j++) {
      grid[i][j] = new ArrayList<Particle>();
    }
  }

  fill(80);
  for (Particle p : particles) {
    int i = floor(p.pos.x / cellWidth);
    int j = floor(p.pos.y / cellHeight);
    grid[i][j].add(p);
    p.gridIndex_i = i;
    p.gridIndex_j = j;
    //rect(i*cellWidth, j*cellHeight, cellWidth, cellHeight);
  }
  fill(255);
}
