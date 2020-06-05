// Assign random pixel values
void assignVals() {
  int x = 0;
  int y = 0;
  for (float[] i : img) {
    for (float f : i) {
      img[y][x] = random(0, 1);
      x++;
    }
    x = 0;
    y++;
  }
}