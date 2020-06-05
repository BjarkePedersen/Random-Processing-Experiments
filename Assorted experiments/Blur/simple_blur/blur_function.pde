// Blur pixels
void blurImg() {
  int x = 0;
  int y = 0;

  // For each pixel in image
  for (float[] i : img) {
    for (float f : i) {
      float kSum = 0;       // Sum of kernel values
      float sum = 0;        // Sum of kernel calculations
      float average = 0;    // Average of kernel calculations

      int kX = 0;
      int kY = 0;
      // For each value in kernel
      for (float[] q : kernel) {
        for (float kernelVal : q) {
          int fY = y+kY-(kSize-1)/2;
          int fX = x+kX-(kSize-1)/2;

          kSum += kernelVal;    // Calculate sum of kernel values (for average)

          if (fY<0 || fY>size-1 ||fX<0 || fX>size-1) {
            sum += 0.5 * kernelVal;  // If edge pixel add 0.5 to sum
          } else {
            sum += img[fY][fX] * kernelVal;  // Add kernel calculation to sum
          }
          kX++;
        }
        kX = 0;
        kY++;
      }
      average = sum / kSum;            // Calculate average
      result[y][x] = average;       // Assign value to new image
      x++;
    }
    x = 0;
    y++;
  }
}