int g = 1;
float tScale = 0.004;   // Time scale
boolean physics = true;
boolean elastic, elasticBtn = false;
boolean grip = true;

void physicsThread() {
  final int ticksPerSecond = 1000;
  final int skipTicks = 1000 / ticksPerSecond;
  final int maxFrameSkip = 5;
  double next_game_tick = System.currentTimeMillis();
  int loops;

  while (physics) {
    loops = 0;
    while (System.currentTimeMillis() > next_game_tick && loops < maxFrameSkip) {
      physics();
      next_game_tick += skipTicks;
      loops++;
    }
  }
}

void physics() {
  if (keyPressed) {
    if (keyCode == RIGHT || key == 'd') {
      PVector body = new PVector(  
        pVerts[1].loc.x -  pVerts[0].loc.x, 
        pVerts[1].loc.y -  pVerts[0].loc.y);
      PVector force = new PVector(  
        pVerts[2].loc.x -  pVerts[1].loc.x, 
        pVerts[2].loc.y -  pVerts[1].loc.y);
      if (PVector.angleBetween(force, body) < PI/4) {
        force.rotate(-90);
        force.normalize();
        pVerts[2].applyForce(force);
      }
    }
    if (keyCode == LEFT || key == 'a') {
      PVector body = new PVector(  
        pVerts[1].loc.x -  pVerts[0].loc.x, 
        pVerts[1].loc.y -  pVerts[0].loc.y);
      PVector force = new PVector(  
        pVerts[2].loc.x -  pVerts[1].loc.x, 
        pVerts[2].loc.y -  pVerts[1].loc.y);
      if (PVector.angleBetween(force, body) < PI/4) {
        force.rotate(90);
        force.normalize();
        pVerts[2].applyForce(force);
      }
    }
    if (keyCode == UP || key == 'w' && !elastic) shrinkRope();
    if (keyCode == DOWN || key == 's' && !elastic) expandRope();


    if (keyCode == SHIFT) changeProperties(1); 
    if (keyCode != SHIFT) elasticBtn = false;

    if (keyCode == 17) g = g == 0 ? 1 : 0;

    if (keyCode == ENTER) shoot(); 
    if (key == 'r' || key == 'R') {
      clearRope();
    }
  }
  // No key pressed
  else {
    elasticBtn = false;
  }

  if (mousePressed && mouseButton == RIGHT) grip = false;

  // Calculate line forces
  for (Line line : lines) line.calcForces();
  for (Line line : pLines) line.calcForces();
  if (grip) gripLine.calcForces(); 

  for (Vert vert : pVerts) {
    vert.vel.add(0, g); 
    vert.move(); 
    vert.collision();
  }


  for (int i=0; i<verts.length; i++) {
     verts[0].fixed = mousePressed;
     verts[0].vel = new PVector(0, -1);
     verts[0].loc = new PVector(400,200);
     verts[0].mass = 9999;
    if (!mousePressed) {
      verts[i].vel.add(0, g); 
      verts[i].move(); 
      verts[i].collision();
      //verts[0].vel = new PVector(0,-1);
      //verts[0].loc = new PVector(width/2, height/4);
    } else {
      verts[0].vel = new PVector(0, -1);
      verts[0].loc = worldMouse();
      if (i != 0) {  // Fix first vert in place
        verts[i].vel.add(0, g); 
        verts[i].move();
      }
      verts[i].collision();
    }
  }
}

void shrinkRope() {
  int l = lines.length-1;
  if (lines.length > 2) {
    lines[l].restLen -= 0.3;
    if (lines[l].restLen < 5) {
      Line[] tmpLines = new Line[lines.length-1];
      Vert[] tmpVerts = new Vert[verts.length-1];
      for (int i=0; i<tmpVerts.length; i++) {
        tmpVerts[i] = new Vert(verts[i].loc, verts[i].mass, verts[i].vel, vertShape, 7);
      }
      for (int i=0; i<tmpLines.length; i++) {
        tmpLines[i] = new Line(tmpVerts[i], tmpVerts[i+1]);
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts[lines.length], pVerts[0]);
    }
  }
}

void expandRope() {
  int l = lines.length-1;
  int v = verts.length+1;
  if (lines.length < maxRopeLen && lines.length >= 2) {
    lines[l].restLen += 0.3;
    if (lines[l].restLen > ropeElmLen*1.8) {      
      Line[] tmpLines = new Line[lines.length+1];
      Vert[] tmpVerts = new Vert[verts.length+1];
      for (int i=0; i<tmpVerts.length; i++) {
        if (i < v-1) tmpVerts[i] = new Vert(verts[i].loc, verts[i].mass, verts[i].vel, vertShape, 7);
        else if (i == v-1) {
          PVector dir = gripLine.v1dir;
          dir.normalize();
          dir.mult(ropeElmLen/4);      
          tmpVerts[i] = new Vert(
            new PVector(verts[i-1].loc.x + dir.x, verts[i-1].loc.y + dir.y), 
            (verts[i-2].mass + verts[i-1].mass) / 2, 
            new PVector(((verts[i-1].vel.x + verts[i-2].vel.x) / 2), (verts[i-1].vel.y + verts[i-2].vel.y) / 2), 
            vertShape, 
            7
            );
        } else if (i == v) {
          tmpVerts[i] = new Vert(verts[i].loc, verts[i].mass, verts[i].vel, vertShape, 7);
        }
      }
      for (int i=0; i<tmpLines.length; i++) {
        tmpLines[i] = new Line(tmpVerts[i], tmpVerts[i+1]);
        //if (i > 0) tmpLines[i].restLen = lines[i-1].restLen;  // Fixes rope shortening bug
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts[lines.length], pVerts[0]);
    }
  }
}

void expandRopeShoot() {
  int l = lines.length-1;
  int v = verts.length+1;
  if (lines.length < maxRopeLen && lines.length >= 2) {
    lines[l].restLen += 0.3;
    if (lines[l].restLen > ropeElmLen*1.3) {      
      Line[] tmpLines = new Line[lines.length+1];
      Vert[] tmpVerts = new Vert[verts.length+1];

      PVector dir = gripLine.v1dir;
      //for (int i=0; i<verts.length; i++) {
      //  verts[i].vel = dir.mult(-10);
      //}
      for (int i=0; i<tmpVerts.length; i++) {
        //PVector dir = gripLine.v1dir;
        dir.normalize();
        dir.mult(-ropeElmLen/10);
        PVector vel = new PVector(dir.x, dir.y).mult(-10);
        if (i < v-1) tmpVerts[i] = new Vert(verts[i].loc, verts[i].mass, verts[i].vel.add(vel), vertShape, 7);
        else if (i == v-1) { 
          tmpVerts[i] = new Vert(
            new PVector(verts[i-1].loc.x + dir.x, verts[i-1].loc.y + dir.y), 
            (verts[i-2].mass + verts[i-1].mass) / 2, 
            new PVector(((verts[i-1].vel.x + verts[i-2].vel.x) / 2), (verts[i-1].vel.y + verts[i-2].vel.y) / 2).add(vel), 
            vertShape, 
            7
            );
        } else if (i == v) {
          tmpVerts[i] = new Vert(verts[i].loc, verts[i].mass, verts[i].vel, vertShape, 7);
        }
      }
      for (int i=0; i<tmpLines.length; i++) {
        tmpLines[i] = new Line(tmpVerts[i], tmpVerts[i+1]);
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts[lines.length], pVerts[0]);
    }
  }
}

void changeProperties(int property) {
  if (property == 1) {
    boolean prevElasticBtn = elasticBtn;
    elasticBtn = true;
    if (elasticBtn != prevElasticBtn) elastic = !elastic;
    if (elastic) {
      for (Line line : lines) {
        strokeWeight(1);
        line.pull = 0.4/tScale;
        line.push = 0.4/tScale;
        line.damp = 0.05/tScale;
      }
    } else {
      for (Line line : lines) {
        strokeWeight(3);
        line.pull = 0.999/tScale;
        line.damp = 0.999/tScale;
        line.push = 0.99/tScale;
      }
    }
  }
}

void shoot() {
  // Angle gripline towards mouse
  PVector dir = new PVector(worldMouse().x-pVerts[0].loc.x, worldMouse().y-pVerts[0].loc.y);
  dir.normalize();
  float mag = gripLine.getLength();
  verts[lines.length].loc = new PVector(dir.x, dir.y).mult(mag).add( pVerts[0].loc);
  expandRopeShoot();
}

void clearRope() {
  Line[] tmpLines = new Line[1];
  Vert[] tmpVerts = new Vert[2];
  tmpVerts[0] = verts[verts.length-1];

  PVector dir = gripLine.v1dir;
  dir.normalize();
  dir.mult(ropeElmLen);      
  tmpVerts[1] = new Vert(
    new PVector(tmpVerts[0].loc.x + dir.x, tmpVerts[0].loc.y + dir.y), 
    tmpVerts[0].mass, 
    tmpVerts[0].vel, 
    vertShape, 
    7
    );

  verts = tmpVerts;
  gripLine = new Line(verts[0], pVerts[0]);
  tmpLines[0] = new Line(verts[0], verts[1]);
  lines = tmpLines;
}
