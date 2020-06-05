void setup() {
  size(800, 800, P3D);
  pixelDensity(displayDensity());
  smooth(8);
  rectMode(CENTER);
  stroke(255);
  strokeWeight(4);
  noFill();
}

float t = 0;
void draw() {
  background(25);
  translate(width/2, width/2, width/2 );
  rotateY(t);
  rotateZ(t/2);
  rotateX(t/8);
  t += 0.006;

  stroke(255);
  beginShape();
  vertex(-50,-50,-50);
  vertex(50,-50,-50);
  vertex(50,50,-50);
  vertex(-50,50,-50);
  endShape();
  
  stroke(255,100,100);
  beginShape();
  vertex(-50,-50,50);
  vertex(-50,-50,-50);
  vertex(-50,50,-50);
  vertex(-50,50,50);
  endShape();
  
  stroke(0,255,0);
  beginShape();
  vertex(50,50,50);
  vertex(-50,50,50);
  vertex(-50,-50,50);
  vertex(50,-50,50);
  endShape();
  
  stroke(40,60,255);
  beginShape();
  vertex(50,50,-50);
  vertex(50,50,50);
  vertex(50,-50,50);
  vertex(50,-50,-50);
  endShape();
}