
void setup() {
  fullScreen();
  noStroke();
}

void draw() {
  background(0,0,255);
  
  fill(0,255,0);
  rect(140,height-50,width-140*2,-400);
  
  fill(255,0,255);
  rect (430, 200, width-430*2, 400);
}