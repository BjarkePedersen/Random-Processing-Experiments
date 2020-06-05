
void createShapes() {
  vertShape = createShape(ELLIPSE, 0, 0, 7, 7);
  vertShape.setStroke(false);
  
  pVertShape = createShape(ELLIPSE, 0, 0, 11, 11);
  pVertShape.setStroke(false);
  pVertShape.setFill(color(255,50,50));
  
}

void showRope() {
  beginShape();
  //strokeWeight(2);
  curveVertex(verts.get(0).loc.x, verts.get(0).loc.y);
  for (Vert vert : verts) { curveVertex(vert.loc.x, vert.loc.y); }
  if (grip) curveVertex(pVerts[0].loc.x, pVerts[0].loc.y);
  if (grip) curveVertex(pVerts[0].loc.x, pVerts[0].loc.y);
  endShape();
}

Edge e1 = new Edge(new PVector(0, 50), new PVector(200, 0));
Edge e2 = new Edge(new PVector(0, 50), new PVector(100, 200));
Edge e3 = new Edge(new PVector(100, 200), new PVector(200, 0));
Edge[] list = {e1, e2, e3};
Object test = new Object(new PVector(500, 500), list);
