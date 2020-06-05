public class Vert {
  PVector loc, prevLoc, prevPrevLoc;
  ;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float mass;
  float gDamp = 0.05;
  PShape shape;
  float diameter;
  boolean fixed;

  public Vert(PVector loc, float mass, PVector vel, PShape shape, float diameter) {
    this.loc = loc;
    this.mass = mass;
    this.vel = vel;
    this.shape = shape;
    this.diameter = diameter;
    gDamp *= tScale;
    gDamp = 1 - gDamp;
  }

  void applyForce(PVector force) {
    ;
    vel = vel.add(force);
  }

  void move() {
    prevPrevLoc = prevPrevLoc == null ? new PVector(loc.x, loc.y) : new PVector(prevLoc.x, prevLoc.y);
    prevLoc = new PVector(loc.x, loc.y);

    vel.add(acc); 
    vel = vel.mult(gDamp);  // Global velocity dampening
    loc = loc.add(vel.x * tScale, vel.y * tScale);
  }

  void show() {
    //ellipse(loc.x, loc.y, 7, 7);
    shape(shape, loc.x, loc.y);
  }

  void collision() {
    if (loc.y >= height) {
      loc.y = prevLoc.y;
      vel.y *= -1;
    }
    if (loc.y <= 0) {
      loc.y = prevLoc.y;
      vel.y *= -1;
    }
    if (loc.x >= width) {
      loc.x = prevLoc.x;
      vel.x *= -1;
    }
    if (loc.x <= 0) {
      loc.x = prevLoc.x;
      vel.x *= -1;
    }
    // Bounding box colission
    if (boundingBoxColission(test, loc)) {
      objectCollision(test, this, diameter, prevPrevLoc);
    }
  }
}

void objectCollision(Object o, Vert vert, float di, PVector prevLoc) {
  // Ball coordinates
  float cx = vert.loc.x;
  float cy = vert.loc.y;

  // For each edge in objecloct
  for (Edge e : o.edges) { 
    float x1 = e.p1.x + o.loc.x;
    float y1 = e.p1.y + o.loc.y;
    float x2 = e.p2.x + o.loc.x;
    float y2 = e.p2.y + o.loc.y;

    PVector lineVector = new PVector(x2 - x1, y2 - y1);

    // Check collision with edge points
    boolean inside1 = pointCircle(x1, y1, cx, cy, di/2);
    boolean inside2 = pointCircle(x2, y2, cx, cy, di/2);
    if (inside1 || inside2) collide(lineVector, vert, prevLoc);
    else {

      float len = lineVector.mag();
      float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len, 2);

      // Closest point to circle on line
      float closestX = x1 + (dot * (x2-x1));
      float closestY = y1 + (dot * (y2-y1));


      // Check if closest point is on line
      if ( linePoint(x1, y1, x2, y2, closestX, closestY) ) {

        // Distance from ball to line
        float distX = closestX - cx;
        float distY = closestY - cy;
        float d = sqrt( (distX*distX) + (distY*distY) );

        if (d < di/2) { 
          collide(lineVector, vert, prevLoc);
        }
      }
    }
  }
}

void collide(PVector lineVector, Vert vert, PVector prevLoc) {
  // Project velocity vector onto line vector
  float scalar = vert.vel.dot(lineVector) / pow((lineVector.mag()), 2);
  PVector proj = lineVector;
  proj.mult(-2 * scalar);

  vert.loc = prevLoc;
  vert.vel = vert.vel.mult(-1).sub(proj);
}

// Check if point is in bounding box
boolean boundingBoxColission(Object o, PVector loc) {
  if (loc.x > o.loc.x + o.minX && loc.x < o.loc.x + o.maxX)
    if (loc.y > o.loc.y + o.minY && loc.y < o.loc.y + o.maxY)
      return true;

  return false;
}

// Check if point is on line
boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, x2, y2);
  float buffer = 0.1;
  float lineLen = dist(x1, y1, x2, y2);
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) return true;

  return false;
}

// Check if point is inside circle
boolean pointCircle(float px, float py, float cx, float cy, float r) {
  float distX = px - cx;
  float distY = py - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );
  if (distance <= r) return true;

  return false;
}
