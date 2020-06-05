public class Vert {
  PVector loc, prevLoc;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float mass;

  public Vert(PVector loc, float mass, PVector vel) {
    this.loc = loc;
    this.mass = mass;
    this.vel = vel;
  }

  void applyForce(PVector force) {
    vel = vel.add(force);
  }

  void move() {
    prevLoc = new PVector(loc.x, loc.y);

    vel.add(acc); 
    vel = vel.mult(gDamp);  // Global velocity dampening
    loc = loc.add(vel.x * tScale, vel.y * tScale);
  }

  void show() {
    ellipse(loc.x, loc.y, 10, 10);
  }

}