int g = 1;
float tScale = 0.00003;   // Time scale
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
  
  // Calculate line forces
  for (Line line : lines) line.calcForces();
  angleSpring1.calcForces();
          
       
  for (int i=0; i<verts.length; i++) {
      verts[0].loc = new PVector(300, 300); // Fix first vert in place
      
      if (i != 0) {  // Fix first vert in place
        verts[i].vel.add(0,g); verts[i].move();
      }
    }
  }
