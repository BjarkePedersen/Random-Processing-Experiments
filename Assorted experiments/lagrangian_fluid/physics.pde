
void physics() {
  // update p(x,y)
  for (int x=1; x<gridSize-1; x++) {
    for (int y=1; y<gridSize-1; y++) {
      PVector px = new PVector(vx[x-1][y].x - vx[x+1][y].x, vx[x][y].y);
      PVector py = new PVector(vy[x][y].x, vy[x][y-1].y - vy[x][y+1].y);
      p[x][y] = px.add(py).mult(0.5);
    }
  }
  //update velocities
  for (int x=1; x<gridSize-1; x++) {
    for (int y=1; y<gridSize-1; y++) {
      //vx[x][y].add( p[x-1][y].sub(p[x+1][y]).mult(0.5) );
      vx[x][y] = new PVector( p[x-1][y].x - p[x+1][y].x, p[x-1][y].x - p[x+1][y].y).mult(0.5);
      //vy[x][y].add( p[x][y-1].sub(p[x][y+1]).mult(0.5) );
      vy[x][y] = new PVector( (p[x][y-1].x - p[x][y+1].x), p[x][y-1].x - p[x][y+1].y).mult(0.5);

      if ( friction ) {
        vx[x][y].mult(0.99);
        vy[x][y].mult(0.99);
      }
    }
  }
}
