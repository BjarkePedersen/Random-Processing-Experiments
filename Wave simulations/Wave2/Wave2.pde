ArrayList<Column> columns;
int num = 50;
float[] positions = new float[num];

void setup() {
  size(800, 400);
  fill(60, 180, 200);
  stroke(25);
  
  columns = new ArrayList<Column>();
  for (int i = 0; i < num; ++i) {  columns.add(new Column(i));  columns.get(i).sharePos(); }
}


void keyPressed() {
  if (key == ENTER) {
    columns.get(0).move(50);
  }
}

void draw() {
  frameRate(999);
  background(25);
  
  if (mousePressed && (mouseButton == LEFT)) {
    columns.get(0).move(abs(mouseY-height));
  }
  if (mousePressed && (mouseButton == RIGHT)) {
    columns.get(num-1).move(abs(mouseY-height));
  }
  
  for (Column i : columns) {  i.sharePos();          }
  for (Column i : columns) {  i.forces();            }
  for (Column i : columns) {  /*i.physics();*/ i.show(); }

  
}