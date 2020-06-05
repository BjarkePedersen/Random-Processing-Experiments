// Generate kernel
static float[][] kernel(int size) { 
  float[][] kernel = new float[size][size];
  
  int x = 0;
  int y = 0;
  for (float[] i : kernel) {
    for (float f : i) {
      kernel[y][x] = (1/(2*PI*pow(1,2)))*pow(2.718,-((pow(map(x,0,size-1,-4,4),2)+pow(map(y,0,size-1,-4,4),2))/(2*pow(1,2))));
      // Gaussian function 2D: https://homepages.inf.ed.ac.uk/rbf/HIPR2/gsmooth.htm
      x++;
    }
    x = 0;
    y++;
  }
  
  return kernel;
}