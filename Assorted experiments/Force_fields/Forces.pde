
void initializeForces() {
  // Create grid of forces. Forces are vectors
  forces = new PVector[width/25][width/25];
  for (int i=0; i<forces.length; i++) {
    for (int p=0; p<forces[i].length; p++) {
      float y = i;
      float x = p;
      float l = forces.length;
      
      // Create force vector (inwards force + circular force = spiral force)
      // Inwards force
      forces[i][p]= new PVector(
        cos(PI*x/l)*sin(PI*y/l) /10,  
        cos(PI*y/l)*sin(PI*x/l) /10
        );
           
     // Circular force
     forces[i][p].x += cos(PI*y/l)*sin(PI*x/l) /10;
     forces[i][p].y += -1*cos(PI*x/l)*sin(PI*y/l) /10;
     
    }
  }
}

void showForces() {
 
  // Grid
  if (displayGrid) {
    stroke(100);
    for (int i=0; i<forces.length; i++) {
      line(i*25,0,i*25,height);
      line(0,i*25,width,i*25);
    }
  }
  // Force direction line
  for (int i=0; i<forces.length; i++) {
    for (int p=0; p<forces[i].length; p++) {
      // Angle of force vector
      float angle = forces[i][p].heading();
      
      // Angle to hue
      color c = Color.HSBtoRGB(
      map(angle, 0, PI*2, 0, 1), 
      .75, 
      .75);
      
      stroke(c);
      line(
        12.5+25*p, 
        12.5+25*i,
        12.5+25*p+forces[i][p].x*200, 
        12.5+25*i+forces[i][p].y*200);
    }
  }
}