public class Branch {
  PVector begin;
  PVector end;
  float rand;
  boolean finished = false;
  float rotation = 0;

  public Branch(PVector begin, PVector end) {
    this.begin = begin;
    this.end = end;
  }

  public void show() {
    line(this.begin.x, this.begin.y, this.end.x, this.end.y);
  }

  public void branch(int direction, Branch targetBranch) {
    PVector dir = new PVector(this.end.x-this.begin.x, this.end.y-this.begin.y);
    dir.rotate(rad(direction*angle+wind));
    dir.mult(0.6667);
    PVector newEnd = new PVector(this.end.x+dir.x, this.end.y+dir.y);
    targetBranch.begin = this.end;
    targetBranch.end = newEnd;
  }
}