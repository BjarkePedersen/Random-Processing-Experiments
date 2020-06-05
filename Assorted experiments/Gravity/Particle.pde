
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
      float l = sqrt(pow(f.x, 2) + pow(f.y, 2));
      l = pow(l, 2);
      if (l < 100) l = 100;

      f.div(l);
      f.mult(0.1);
      f.mult(pow(p.mass,2));
      f.div(pow(mass,2));
      //println(f);
      if (!Float.isNaN(f.x) && !Float.isNaN(f.y))  applyForce(f);
    }
  }

  void applyForce(PVector f) {
    //println(vel);
    vel.add(f);
  }

  void move() {
    //vel.add(acc);
    //if (vel.x > 10 ) vel.x = 10;
    //if (vel.y > 10 ) vel.y = 10;
    loc.add(vel);
  }

  void show() {
    ellipse(loc.x, loc.y, mass+1, mass+1);
    //line(loc.x, loc.y, loc.x + vel.x * 100, loc.y + vel.y * 100);
  }
}