void makeNoise() {
  if (allowNoise) {  // If there is no data to import, generate random noise instead
    int x = 0;
    int y = 0;
    for (int[] i : img) {
      for (int f : i) {
        float val = random(0, 1);
        if (val>0.5) {
          img[y][x] = 1;
        }
        x++;
      }
      x = 0;
      y++;
    }
  }
}