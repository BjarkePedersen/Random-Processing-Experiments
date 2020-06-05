
void mainThread() {
  while(t < 30000) {
    t++;
    sharePos();
    forces();
    physics();
    sine();
  }
  println("Done");
}