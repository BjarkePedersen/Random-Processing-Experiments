
int scale = 5;  // Downsize factor for faster blurring (Higher = faster, lower quality)
int blur = 20;  // Blur size
int w, h;


PImage img;
PGraphics pg;

void setup() {
  size(800,800, P2D);
  pixelDensity(displayDensity());
  
  img = loadImage("yo.jpg");
  
  scale *= displayDensity();
  blur *= displayDensity();
  blur /= scale;
  w = width / scale;
  h = height / scale;
  
  pg = createGraphics(w, h);
  
  println("Hold any key to blur.");
  println("Be patient with if using a low scale factor");
 
}

void draw() {
  background(25);
  
  if (keyPressed || mousePressed) {
    pg.beginDraw();
    pg.image(img, 0, 0, w, h);
    pg.filter(BLUR, blur);
    pg.endDraw();
    image(pg, 0, 0, width, height);}
  else image(img, 0, 0, width, height);
}