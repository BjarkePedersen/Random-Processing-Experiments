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
    for (int i=0; i<verts.length; i++) {
      for (Vert vert : verts[i]) vert.loc = new PVector(random(0, 800), random(0, 800));
    }
    if (keyCode == RIGHT || key == 'd') {
    }
  }
  // No key pressed
  else {
    elasticBtn = false;
  }

  // Calculate line forces
  for (Line line : lines) line.calcForces();

  for (int i=0; i<verts.length; i++) {
    for (int j=0; j<verts[i].length; j++) {
      if (!mousePressed) {
        verts[i][j].vel.add(0, g); 
        verts[i][j].move(); 
        verts[i][j].collision();
      } else {
        for (int x=0; x<verts.length; x++) {
          verts[x][0].vel = new PVector(0, -1);
          verts[x][0].loc = new PVector(mouseX+x*ropeElmLen, mouseY);
        }
        
        if (i*verts.length + j != 0) {
          verts[i][j].vel.add(0, g); 
          verts[i][j].move();
        }
        verts[i][j].collision();
      }
    }
  }
}
