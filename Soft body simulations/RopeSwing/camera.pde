
PVector camLoc = new PVector(0,0);

void moveCamera() {
  camLoc.x += (pVerts[0].loc.x-camLoc.x)/20;
  camLoc.y += (pVerts[0].loc.y-camLoc.y)/20;
}

PVector worldMouse() {
  return new PVector (mouseX+camLoc.x-width/2, mouseY+camLoc.y-height/2);
}
