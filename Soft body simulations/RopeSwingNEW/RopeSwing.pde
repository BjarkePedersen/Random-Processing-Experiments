//Vert[] verts = new Vert[8];
//Line[] lines = new Line[verts.length-1];
int startVerts = 8;
ArrayList<Vert> verts = new ArrayList<Vert>();
ArrayList<Line> lines = new ArrayList<Line>();
Vert[] pVerts = new Vert[3];
Line[] pLines = new Line[2];
Line gripLine;

PShape[] curves = new PShape[startVerts];

int ropeElmLen = 25;
int maxRopeLen = 25;

PShape vertShape, pVertShape;

void setup() {
  size(800, 800, OPENGL);
  pixelDensity(displayDensity());
  //fullScreen(OPENGL);
  smooth(8);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);

  createShapes();
  noFill();
  
  for (int i=0; i<startVerts; i++) 
    verts.add( new Vert(new PVector(500-i*ropeElmLen, 200), 1, new PVector(0, 0), vertShape, 7) );
  
  for (int i=0; i<verts.size()-1; i++) 
    lines.add( new Line(verts.get(i), verts.get(i+1)) );

  for (int i=0; i<pVerts.length; i++)
    pVerts[i] = new Vert(new PVector(500-i*ropeElmLen, 100), 5, new PVector(0, 0), pVertShape, 11);

  for (int i=0; i<pLines.length; i++) 
    pLines[i] = new Line(pVerts[i], pVerts[i+1]);

  gripLine = new Line(verts.get(lines.size()), pVerts[0]);
  pLines[1].restLen *= 1.5; // Tweak body shape

  // Start physics thread
  thread("physicsThread");
}

void print() {
  println(verts.get(0).loc);
}

void draw() {
  //frameRate(60);   // Doesn't work with P2D
  background(25);
  
  translate(-camLoc.x+width/2, -camLoc.y+height/2);
  moveCamera();

  
  stroke(255);
  rect(0,0,width,height);

  // Show verts
  for (Vert vert : verts) vert.show();
  for (Vert vert : pVerts) vert.show();

  // Show lines
  showRope();
  //for (int i=0; i<pLines.length; i++) pLines[i].show(i, "body");

  stroke(255, 100, 100);
  //test.showBound();
  stroke(255);
  

  test.show();

  //thread("print");
} 
