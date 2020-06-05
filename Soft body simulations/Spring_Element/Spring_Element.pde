
Vert[] verts = new Vert[8];

Line[] lines = new Line[verts.length-1];

float tScale = 0.01;   // Time scale

void setup() {
  size(800, 800);
  //fullScreen();
  fill(255);
  stroke(255);
  ellipseMode(CENTER);

  for (int i=0; i<verts.length; i++) {
    verts[i] = new Vert(new PVector(100+i*25, 200), 1);
  }
  
  for (int i=0; i<lines.length; i++) {
    lines[i] = new Line(verts[i], verts[i+1]);
  }
  
  
  // Box
  /*
  l1 = new Line(verts[0], verts[1]);
  l2 = new Line(verts[1], verts[3]);
  l3 = new Line(verts[3], verts[2]);
  l4 = new Line(verts[0], verts[2]);
  
  l5 = new Line(verts[0], verts[3]);
  l6 = new Line(verts[2], verts[1]);
  */

  
}


void draw() {
  frameRate(500);
  background(25);
  
  if (keyPressed){
    if (keyCode == RIGHT) {
      PVector force = new PVector(
        verts[verts.length-2].loc.x - verts[verts.length-1].loc.x,
        verts[verts.length-2].loc.y - verts[verts.length-1].loc.y
      );
      force.rotate(90);
      force.normalize();
      
      verts[verts.length-1].applyForce(force);
    }
    
    if (keyCode == LEFT) {
      PVector force = new PVector(
        verts[verts.length-2].loc.x - verts[verts.length-1].loc.x,
        verts[verts.length-2].loc.y - verts[verts.length-1].loc.y
      );
      force.rotate(-90);
      force.normalize();
      
      verts[verts.length-1].applyForce(force);
    }
    
    if (keyCode == UP) {
      lines[0].restLen -= 0.1;
    }
    if (keyCode == DOWN) {
      lines[0].restLen += 0.1;
    }
  }
  
  trimRope();
  
  // Calculate line forces
  for (Line line : lines) {
    line.calcForces();
  }
     
  for (int i=0; i<verts.length; i++) {
    if (!mousePressed) {
      /*
      if (i != 0) {  // Fix first vert in place
        verts[i].vel.add(0,2);
        verts[i].move();
        verts[i].collision();
      }
      */
      verts[i].vel.add(0,2);
      verts[i].move();
      verts[i].collision();
      verts[i].show();
    }else {
      verts[0].vel = new PVector(0,-1);
      verts[0].loc = new PVector(mouseX, mouseY);
      if (i != 0) {  // Fix first vert in place
        verts[i].vel.add(0,2);
        verts[i].move();
      }
      verts[i].collision();
      verts[i].show();
    }
    
  }
  
  // Show lines
  for (Line line : lines) {
    line.show();
  }
  
}