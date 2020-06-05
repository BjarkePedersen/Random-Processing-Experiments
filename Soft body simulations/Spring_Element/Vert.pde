
public class Vert {
  PVector loc, prevLoc;
  PVector vel = new PVector(0,0);
  PVector acc = new PVector(0,0);
  float mass;
  float gDamp = 0.05;
   
  
  public Vert(PVector loc, float mass) {
    this.loc = loc;
    this.mass = mass;
    gDamp *= tScale;
    gDamp = 1 - gDamp;    
  }

  void applyForce(PVector force) {;
    vel = vel.add(force);
  }

  void move() {
    prevLoc = new PVector(loc.x, loc.y);
    
    vel.add(acc); 
    vel = vel.mult(gDamp);  // Global velocity dampening
    loc = loc.add(vel.x * tScale, vel.y * tScale);
  }
  
  void show() {
    ellipse(loc.x, loc.y, 5, 5);
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
  }
  
}