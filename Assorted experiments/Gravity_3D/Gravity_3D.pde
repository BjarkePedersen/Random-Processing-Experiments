

P[] ps = new P[1000];

int s = 200;

void setup() {
  size(800, 800, P3D);
  //fullScreen(P3D);
  pixelDensity(displayDensity());
  smooth(8);
  stroke(255);
  strokeWeight(4);
  ellipseMode(CENTER);
  background(25);
  noFill();
    
  for (int i=0; i<ps.length; i++) {
    ps[i] = new P(new PVector(width/2 + random(-100,100), height/2 + random(-100,100), height/2 + random(-100,100)), 1);
  }
  
  mouseLoc = new PVector(0,0);
  mouseSum = mouseLoc;
  
  thread("t1");

}

float scroll = 10;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scroll += e /1000 ;
  scroll = abs(scroll);
}

PVector prevMouseLoc, mouseLoc, mouseSum;

void draw() {
  background(25);
  
  translate(width/2, width/2, width/scroll );
 
  prevMouseLoc = mouseLoc;
  mouseLoc = new PVector(mouseX, mouseY);
  PVector mouseDiff = new PVector(mouseLoc.x - prevMouseLoc.x, mouseLoc.y - prevMouseLoc.y);
  if (mousePressed)
    mouseSum = new PVector(mouseSum.x + mouseDiff.x, mouseSum.y + mouseDiff.y);
  
  if (mouseSum.y > PI / 2 * 200) mouseSum.y = PI / 2 * 200;
  if (mouseSum.y < - PI / 2 * 200) mouseSum.y = - PI / 2 * 200;
  rotateX(-mouseSum.y / 200);
  rotateY(mouseSum.x / 200);
  
  
  strokeWeight(1);
  stroke(255);
  for (P p : ps) {p.show(); }
  
  
  strokeWeight(0.2);

  strokeWeight(4);
  stroke(255);

  beginShape();
  vertex(-s, -s, -s);
  vertex(s, -s, -s);
  vertex(s, s, -s);
  vertex(-s, s, -s);
  endShape();

  beginShape();
  vertex(-s, -s, s);
  vertex(-s, -s, -s);
  vertex(-s, s, -s);
  vertex(-s, s, s);
  endShape();

  beginShape();
  vertex(s, s, s);
  vertex(-s, s, s);
  vertex(-s, -s, s);
  vertex(s, -s, s);
  endShape();

  beginShape();
  vertex(s, s, -s);
  vertex(s, s, s);
  vertex(s, -s, s);
  vertex(s, -s, -s);
  endShape();
  
  strokeWeight(5);
  s -= 1;
  stroke(255,0,0);
  line(-s,-s,-s,-s + 50,-s,-s);
  stroke(0,255,0);
  line(-s,-s,-s,-s ,-s + 50,-s);
  stroke(0,0,255);
  line(-s,-s,-s,-s,-s,-s + 50);
  s += 1;
}