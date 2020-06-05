

class Ball {
  PVector loc, prevLoc;
  PVector vel = new PVector(0, 0);

  public Ball(PVector loc) {
    this.loc = loc;
  }

  void gravity() {
    PVector f = new PVector(0, 0.1);
    applyForce(f);
  }

  void applyForce(PVector f) {
    prevLoc = loc;
    vel.add(f);
    loc.add(vel);
  }

  void checkCollision() {
    // Ball coordinates
    float cx = ball.loc.x;
    float cy = ball.loc.y;
    
    PVector lineVector = new PVector(x2 - x1, y2 - y1);

    // Check collision with edge points
    boolean inside1 = pointCircle(x1, y1, cx, cy, di/2);
    boolean inside2 = pointCircle(x2, y2, cx, cy, di/2);
    if (inside1 || inside2)  collide(lineVector); //fill(255, 0, 0);
    else {

      float len = lineVector.mag();
      float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len, 2);

      // Closest point to circle on line
      float closestX = x1 + (dot * (x2-x1));
      float closestY = y1 + (dot * (y2-y1));

      // Check if closest point is on line
      if ( linePoint(x1, y1, x2, y2, closestX, closestY) ) {
        //ellipse(closestX, closestY, 10, 10);

        // Distance from ball to line
        float distX = closestX - cx;
        float distY = closestY - cy;
        float d = sqrt( (distX*distX) + (distY*distY) );

        if (d < di/2) collide(lineVector); //fill(255, 0, 0);
        else fill(255);
      } else fill(255);
    }
  }
  
  void collide(PVector lineVector) {
    // Project velocity vector onto line vector
    float scalar = ball.vel.dot(lineVector) / pow((lineVector.mag()),2);
    PVector proj = lineVector;
    proj.mult(-2 * scalar);
    
    ball.loc = prevLoc;
    ball.vel = ball.vel.mult(-1).sub(proj);
  }

  void show() {
    ellipse(loc.x, loc.y, di, di);
  }
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