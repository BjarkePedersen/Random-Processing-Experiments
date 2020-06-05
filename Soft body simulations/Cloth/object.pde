

class Edge {
  PVector p1, p2;

  public Edge(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
}

class Object {
  PVector loc;
  Edge[] edges;

  float[] bound = new float[4];

  float minX = Float.MAX_VALUE;
  float maxX = -Float.MAX_VALUE;
  float minY = Float.MAX_VALUE;
  float maxY = -Float.MAX_VALUE;

  public Object(PVector loc, Edge[] edges) {
    this.loc = loc;
    this.edges = edges;
    
    // Create bounding box
    for (Edge e : edges) {
      if (e.p1.x < minX) { minX = e.p1.x; }
      if (e.p2.x < minX) { minX = e.p2.x; }
      if (e.p1.y < minY) { minY = e.p1.y; } 
      if (e.p2.y < minY) { minY = e.p2.y; }
      if (e.p1.x > maxX) { maxX = e.p1.x; }
      if (e.p2.x > maxX) { maxX = e.p2.x; }
      if (e.p1.y > maxY) { maxY = e.p1.y; } 
      if (e.p2.y > maxY) { maxY = e.p2.y; }
    }
  }

  void show() {
    for (Edge e : edges) {
      line(loc.x + e.p1.x, loc.y + e.p1.y, loc.x + e.p2.x, loc.y + e.p2.y);
    }
  }

  void showBound() {
    rect(loc.x + minX, loc.y + minY,  maxX,  maxY);
  }
}