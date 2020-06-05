boolean pause = true;
boolean fullPause = false;

void changePause() {
  pause = !pause;
  fullPause = !fullPause;
  if (pause) button1.shape.setFill(color(255));
  else button1.shape.setFill(color(col1));
}
