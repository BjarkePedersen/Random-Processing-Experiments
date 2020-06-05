
Ball ball;

//// Line
//float x1 = 300;
//float y1 = 750;
//float x2 = 700;
//float y2 = 600;

float x1 = 300;
float y1 = 600;
float x2 = 600;
float y2 = 500;

//// Ball
int di = 25;

void setup() {
  size(800,800, P2D);
  size(800,800);
  pixelDensity(displayDensity());
  smooth(8);
  ellipseMode(CENTER);
  
  ball = new Ball(new PVector(400, 300));
}

void draw() {
  //frameRate(2);
  background(25);
   
  //noStroke();
  ball.gravity();
  //ball.loc.x = mouseX;
  //ball.loc.y = mouseY;
  ball.checkCollision();
  ball.show();
  
  if (ball.loc.y > height) { ball.loc = new PVector(random(300, width-200), 300); ball.vel.mult(0); }
  
  stroke(255);
  line(x1, y1, x2, y2);
}