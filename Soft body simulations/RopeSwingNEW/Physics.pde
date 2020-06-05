int g = 0;
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
  
  
  // Calculate vert forces
  if (!mousePressed) {
    for (int i=0; i<verts.size(); i++) {
      verts.get(i).vel.add(0, g); 
      verts.get(i).move(); 
      verts.get(i).collision();
    }
  } else {
    verts.get(0).vel = new PVector(0, -1);
    verts.get(0).loc = worldMouse();
    for (int i=1; i<verts.size(); i++) {
      verts.get(i).vel.add(0, g); 
      verts.get(i).move();
    }
  }

  for (Vert vert : pVerts) {
    vert.vel.add(0, g); 
    vert.move(); 
    vert.collision();
  }
}

void shrinkRope() {
  int l = lines.size()-1;
  if (lines.size() > 2) {
    lines.get(l).restLen -= 0.3;
    if (lines.get(l).restLen < 5) {
      ArrayList<Line> tmpLines = new ArrayList<Line>();
      ArrayList<Vert> tmpVerts = new ArrayList<Vert>();
      for (int i=0; i<verts.size()-1; i++) {
        tmpVerts.add( new Vert(verts.get(i).loc, verts.get(i).mass, verts.get(i).vel, vertShape, 7) );
      }
      for (int i=0; i<lines.size()-1; i++) {
        tmpLines.add( new Line(tmpVerts.get(i), tmpVerts.get(i+1)));
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts.get(lines.size()), pVerts[0]);
    }
  }
}

void expandRope() {
  int l = lines.size()-1;
  int v = verts.size()+1;
  if (lines.size() < maxRopeLen && lines.size() >= 2) {
    lines.get(l).restLen += 0.3;
    if (lines.get(l).restLen > ropeElmLen*1.8) {      
      ArrayList<Line> tmpLines = new ArrayList<Line>();
      ArrayList<Vert> tmpVerts = new ArrayList<Vert>();
      for (int i=0; i<verts.size()+1; i++) {
        if (i < v-1) tmpVerts.add( new Vert(verts.get(i).loc, verts.get(i).mass, verts.get(i).vel, vertShape, 7) );
        else if (i == v-1) {
          PVector dir = gripLine.v1dir;
          dir.normalize();
          dir.mult(ropeElmLen/4);      
          tmpVerts.add( new Vert(
            new PVector(verts.get(i-1).loc.x + dir.x, verts.get(i-1).loc.y + dir.y), 
            (verts.get(i-2).mass + verts.get(i-1).mass) / 2, 
            new PVector(((verts.get(i-1).vel.x + verts.get(i-2).vel.x) / 2), (verts.get(i-1).vel.y + verts.get(i-2).vel.y) / 2), 
            vertShape, 
            7
            ) );
        } else if (i == v) {
          tmpVerts.add( new Vert(verts.get(i).loc, verts.get(i).mass, verts.get(i).vel, vertShape, 7) );
        }
      }
      for (int i=0; i<lines.size()+1; i++) {
        tmpLines.add( new Line(tmpVerts.get(i), tmpVerts.get(i+1)) );
        //if (i > 0) tmpLines[i].restLen = lines[i-1].restLen;  // Fixes rope shortening bug
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts.get(lines.size()), pVerts[0]);
    }
  }
}

void expandRopeShoot() {
  int l = lines.size()-1;
  int v = verts.size()+1;
  if (lines.size() < maxRopeLen && lines.size() >= 2) {
    lines.get(l).restLen += 0.3;
    if (lines.get(l).restLen > ropeElmLen*1.3) {      
      ArrayList<Line> tmpLines = new ArrayList<Line>();
      ArrayList<Vert> tmpVerts = new ArrayList<Vert>();

      PVector dir = gripLine.v1dir;
      //for (int i=0; i<verts.length; i++) {
      //  verts.get(i).vel = dir.mult(-10);
      //}
      for (int i=0; i<verts.size()+1; i++) {
        //PVector dir = gripLine.v1dir;
        dir.normalize();
        dir.mult(-ropeElmLen/10);
        PVector vel = new PVector(dir.x, dir.y).mult(-10);
        if (i < v-1) tmpVerts.add( new Vert(verts.get(i).loc, verts.get(i).mass, verts.get(i).vel.add(vel), vertShape, 7) );
        else if (i == v-1) { 
          tmpVerts.add( new Vert(
            new PVector(verts.get(i-1).loc.x + dir.x, verts.get(i-1).loc.y + dir.y), 
            (verts.get(i-2).mass + verts.get(i-1).mass) / 2, 
            new PVector(((verts.get(i-1).vel.x + verts.get(i-2).vel.x) / 2), (verts.get(i-1).vel.y + verts.get(i-2).vel.y) / 2).add(vel), 
            vertShape, 
            7
            ) );
        } else if (i == v) {
          tmpVerts.add( new Vert(verts.get(i).loc, verts.get(i).mass, verts.get(i).vel, vertShape, 7) );
        }
      }
      for (int i=0; i<lines.size()+1; i++) {
        tmpLines.add( new Line(tmpVerts.get(i), tmpVerts.get(i+1)) );
      }
      lines = tmpLines;
      verts = tmpVerts;
      gripLine = new Line(verts.get(lines.size()), pVerts[0]);
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
  verts.get(lines.size()).loc = new PVector(dir.x, dir.y).mult(mag).add( pVerts[0].loc);
  expandRopeShoot();
}

void clearRope() {
  ArrayList<Line> tmpLines = new ArrayList<Line>();
  ArrayList<Vert> tmpVerts = new ArrayList<Vert>();
  tmpVerts.add( verts.get(verts.size()-1) );

  PVector dir = gripLine.v1dir;
  dir.normalize();
  dir.mult(ropeElmLen);      
  tmpVerts.add( new Vert(
    new PVector(tmpVerts.get(0).loc.x + dir.x, tmpVerts.get(0).loc.y + dir.y), 
    tmpVerts.get(0).mass, 
    tmpVerts.get(0).vel, 
    vertShape, 
    7
    ) );

  verts = tmpVerts;
  gripLine = new Line(verts.get(0), pVerts[0]);
  tmpLines.add ( new Line(verts.get(0), verts.get(1)) );
  lines = tmpLines;
}
