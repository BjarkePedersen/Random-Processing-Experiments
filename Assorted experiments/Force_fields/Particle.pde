
public class P {
  float locX, locY, accX, accY, velX, velY, prevX, prevY;
  
  public P(float locX, float locY) {
    this.locX = locX;
    this.locY = locY;
  }
  
  void applyForce(float x, float y) {
    velX += x;
    velY += y;
  }
  
  void move(){
    prevX = locX;
    prevY = locY;
  
    // Apply forces from grid
    int fLocX = round(map(locX,0,width,0,31));
    int fLocY = round(map(locY,0,height,0,31));
    accX = forces[fLocY][fLocX].x;
    accY = forces[fLocY][fLocX].y;
    
    velX += accX;
    velY += accY;
    
    locX += velX;
    locY += velY;
    
    // Bondary collision
    if (locX<0      ) {velX*=-1; locX = prevX;}
    if (locX>width  ) {velX*=-1; locX = prevX;}
    if (locY<0      ) {velY*=-1; locY = prevY;}
    if (locY>height ) {velY*=-1; locY = prevY;}
    
  }
  
  void show() {
    color c = Color.HSBtoRGB(
      map( ((abs(velY)+abs(velX))/2), 0, 5, .333, 0), 
      1, 
      1);
    
    particleShape.setFill(c);
    shape(particleShape,locX,locY);
  }
}