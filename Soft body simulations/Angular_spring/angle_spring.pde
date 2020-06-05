
class AngleSpring {
  Vert v1, v2, v3;
  PVector heading1, heading2, force1, force2;
  float tension, damp;
  float restAngle;
  

  public AngleSpring(Vert v1, Vert v2, Vert v3, float tension, float damp) {
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
    this.tension = tension;
    this.damp = damp;
    
    heading1 = new PVector(v2.loc.x - v1.loc.x, v2.loc.y - v1.loc.y);
    heading2 = new PVector(v3.loc.x - v2.loc.x, v3.loc.y - v2.loc.y);
    
    restAngle = PVector.angleBetween(heading1, heading2);;
    
    damp /= tScale;    
    tension /= tScale;
    
  }
  
  void calcForces() {
    heading1 = new PVector(v2.loc.x - v1.loc.x, v2.loc.y - v1.loc.y);
    heading2 = new PVector(v3.loc.x - v2.loc.x, v3.loc.y - v2.loc.y);
    
    float currentAngle = PVector.angleBetween(heading1, heading2);
    
    float angleDiff = restAngle - currentAngle;
    println(angleDiff);
    
    force1 = new PVector(-heading1.y, heading1.x);
    force1.mult(angleDiff * 0.01 * tension);
    
    force2 = new PVector(-heading2.y, heading2.x);
    force2.mult(angleDiff * 0.01 * tension);
    
    v1.applyForce(force1);
    v3.applyForce(force2);
  }
  
  void show() {
    noFill();
    //rect(v1.loc.x, v1.loc.y, 20, 20);
    //rect(v2.loc.x, v2.loc.y, 20, 20);
    //rect(v3.loc.x, v3.loc.y, 20, 20);
    
    line(v3.loc.x, v3.loc.y, v3.loc.x + force2.x*30, v3.loc.y + force2.y*30);
    
    line(200, 200, 200 + heading1.x, 200 + heading1.y);
    line(200, 400, 200 + heading2.x, 400 + heading2.y);
  }
}
