Vert[] verts = new Vert[3];
Line[] lines = new Line[verts.length-1];

float gDamp = 0.0001;

void setup() {
  size(600, 600, OPENGL);
  pixelDensity(displayDensity());
  //fullScreen(OPENGL);
  smooth(8);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);
  colorMode(HSB,255);
  
  gDamp *= tScale;
  gDamp = 1 - gDamp;

  verts[0] = new Vert(new PVector(300, 300), 1, new PVector(0,0));
  verts[1] = new Vert(new PVector(300  + random(-2, 2), 200), 1, new PVector(0,0));
  verts[2] = new Vert(new PVector(300  + random(-2, 2), 100), 1, new PVector(0,0));
  
  for (int i=0; i<lines.length; i++) 
    lines[i] = new Line(verts[i], verts[i+1]); 

  
  // Start physics thread
  thread("physicsThread");
}


void draw() {
  background(25);
     
  color col;
  fill(255);
  stroke(255);
  verts[0].show();
  
  col = color( 150 - mag(verts[1].vel.x, verts[1].vel.y)/4, 255, 255);
  fill(col);
  stroke(col);
  verts[1].show();
  lines[0].show();
  
   col = color( 150 - mag(verts[2].vel.x, verts[2].vel.y)/4, 255, 255);
  fill(col);
  stroke(col);
  verts[2].show();
  lines[1].show();

  
} 
