Vert[][] verts = new Vert[40][40];
ArrayList<Line> lines = new ArrayList<Line>();

PShape[] curves = new PShape[4];

int ropeElmLen = 15;
int maxRopeLen = 25;

PShape vertShape, pVertShape;

void setup() {
  size(800, 800, OPENGL);
  pixelDensity(displayDensity());
  smooth(8);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);

  createShapes();
  noFill();
  
  int max = verts.length * verts[0].length;
  int l = verts.length;
  for (int i=0; i<verts.length; i++) {
    for (int j=0; j<verts[i].length; j++) {
      if (i*l + j < max) {
        verts[i][j] = new Vert(new PVector(50+i*ropeElmLen+random(-1,1), 20 + j*ropeElmLen+random(-1,1)), 1, new PVector(0, 0), vertShape, 7);
      }
    }
  }
  
  for (int i=0; i<verts.length; i++) {
    for (int j=0; j<verts[i].length; j++) {
      if (j != l-1)
        lines.add( new Line(verts[i][j], verts[i][j+1]) );
       
      if (i != l-1) 
        lines.add( new Line(verts[i][j], verts[i+1][j]) );
        
      try {
        //lines.add( new Line(verts[i][j+1], verts[i+1][j]) );
      } catch(Exception e) {}
      try {
        //lines.add( new Line(verts[i][j+1], verts[i-1][j]) );
      } catch(Exception e) {}
      
    }
  }


  // Start physics thread
  thread("physicsThread");
}

void draw() {
  background(25);

  stroke(255);
  rect(0,0,width,height);

  // Show verts
  int index = 0;
  for (int i=0; i<verts.length; i++) {
    for (Vert vert : verts[i]) vert.show();
  }
  

strokeWeight(2);
  for (int i=0; i<lines.size(); i++) lines.get(i).show();
} 
