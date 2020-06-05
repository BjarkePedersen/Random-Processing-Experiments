
void createShapes() {
  vertShape = createShape(ELLIPSE, 0, 0, 7, 7);
  vertShape.setStroke(false);
  
  pVertShape = createShape(ELLIPSE, 0, 0, 11, 11);
  pVertShape.setStroke(false);
  pVertShape.setFill(color(255,50,50));
  
}

void showRope() {
  beginShape();
  curveVertex(verts[0][0].loc.x, verts[0][0].loc.y);
  for (int i=0; i<verts.length; i++)
    for (Vert vert : verts[i]) curveVertex(vert.loc.x, vert.loc.y);
  endShape();
}
