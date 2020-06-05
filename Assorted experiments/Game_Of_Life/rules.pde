void applyRules() {

  // For each pixel in image
  for (int x=0; x<size; x++) {
    for (int y=0; y<size; y++) {
      int sum = 0;


      for (int q=-1; q<2; q++) {
        for (int r=-1; r<2; r++) {
          if (x>0 && x+1<size && y>0 && y+1<size) {    // Fix ArrayOutOfBoundsException 256
            if (q==0 && r==0) {
              ;
            } else {
              sum+= img[x+q][y+r];
            }
          }
        }
      }
      // Rules
      int pixVal = img[x][y];
      if (pixVal==1) {
        if (sum<2) {
          result[x][y] = 0;
        } else if (sum>3) {
          result[x][y] = 0;
        } else if (sum==2 || sum==3) {
          result[x][y] = 1;
        }
      } else if (pixVal==0 && sum==3) {
        result[x][y] = 1;
      } else {
        result[x][y] = 0;
      }
    }
  }

  for (int x=0; x<size; x++) {
    for (int y=0; y<size; y++) {
      img[x][y] = result[x][y];
    }
  }
}