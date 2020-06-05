public class Branch {
  PVector begin;
  PVector end;
  float angle = 45;
  float wind = 10;
  boolean finished = false;
  float stroke = 255;
  float rotate = 0;

  public Branch(PVector begin, PVector end) {
    this.begin = begin;
    this.end = end;
  }
  
  public void wind(int f) {
    end.rotate(sin(rad(f))*0.001);
  }

  public void show() {
    stroke = this.stroke*0.95;
    stroke(stroke*2,stroke*0.25+130,stroke*2+150);
    line(this.begin.x, this.begin.y, this.end.x, this.end.y);
  }

  public Branch branchR() { 
    PVector dir = new PVector(this.end.x-this.begin.x, this.end.y-this.begin.y);
    dir.rotate(rad(angle));
    dir.mult(0.6667);
    PVector newEnd = new PVector(this.end.x+dir.x, this.end.y+dir.y);
    Branch right = new Branch(this.end, newEnd);
    return right;
  }
  
  public Branch branchL() { 
    PVector dir = new PVector(this.end.x-this.begin.x, this.end.y-this.begin.y);
    dir.rotate(rad(-angle));
    dir.mult(0.6667);
    PVector newEnd = new PVector(this.end.x+dir.x, this.end.y+dir.y);
    Branch left = new Branch(this.end, newEnd);
    return left;
  }
}