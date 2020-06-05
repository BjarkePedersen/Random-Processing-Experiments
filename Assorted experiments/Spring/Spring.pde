PVector o;
PVector spring;

float angle = -10;
float restAngle = 0;
float acc;
float vel;

float tension;
float damp;

Slider slider1;
Slider slider2;

void setup() {
  size(400, 400);
  o = new PVector(width/2, height);
  spring = new PVector(0, -width/2);
  // (name, fontSize, line color, handle/text color, width, offset, default value)
  slider1 = new Slider("Tension", 16, color(120,120,120), color(255,255,255), 100, new PVector(10, 10), 0.3);
  slider2 = new Slider("Dampening", 16, color(120,120,120), color(255,255,255), 100, new PVector(10, 50), 0.3);
}

void physics() {
  acc = tension * (restAngle - angle);
  vel += acc;
  vel *= 1-damp;
  angle += vel;
  spring.rotate(rad(angle));

}

void draw() {
  frameRate(60);
  background(50);

  spring = new PVector(0, -width/2);

  if (!mousePressed) {
    physics();
  } else {
    angle = map(mouseX, 0, width, deg(-1), deg(1));
    vel = 0;
    acc = 0;
    spring.rotate(rad(angle));
  }

  stroke(255);
  line(o.x, o.y, spring.x+o.x, spring.y+o.y);
  
  tension = slider1.slide();
  tension = map(pow(tension,3),0,1,0,1);
  slider1.drawSlider(tension);
  
  damp = slider2.slide();
  damp = map(pow(damp, 3),0,1,0,1);
  slider2.drawSlider(damp);
}