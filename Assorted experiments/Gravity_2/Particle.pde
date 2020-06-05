
class P {
  PVector loc;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float mass;

  public P(PVector loc, float mass) {
    this.loc = loc;
    this.mass = mass;
  }

  void forces() {
    for (P p : ps) { 
      PVector f = new PVector(p.loc.x - loc.x, p.loc.y - loc.y); 
      float l = f.mag();

      f.div(l);
      f.mult(0.0005);
      f.mult(pow(p.mass,2));
      f.div(pow(mass,2));
      if (!Float.isNaN(f.x) && !Float.isNaN(f.y))  applyForce(f);
    }
  }

  void applyForce(PVector f) {
    vel.add(f);
  }

  void move() {
    loc.add(vel);
  }

  void show() {
    //ellipse(loc.x, loc.y, mass, mass);
    point(loc.x, loc.y);
    //line(loc.x, loc.y, loc.x + vel.x * 100, loc.y + vel.y * 100);
  }
}
