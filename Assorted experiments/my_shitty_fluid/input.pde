
void input() {
  if (keyPressed) {
    if (keyCode == LEFT) {
      gx = -9.82;
    }
    if (keyCode == RIGHT) {
      gx = 9.82;
    }
    if (keyCode == UP) {
      gy = -9.82;
    }
    if (keyCode == DOWN) {
      gy = 9.82;
    }
  } else {
    gy = 9.82;
    gx = 0;
  }
}
