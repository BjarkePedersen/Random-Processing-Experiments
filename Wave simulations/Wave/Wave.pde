ArrayList<Column> columns;
int num = 50;
float[] positions = new float[num];

void setup() {
  size(800, 400);
  
  columns = new ArrayList<Column>();
  for (int i = 0; i < num; ++i) {  columns.add(new Column(i));  columns.get(i).sharePos(); }
}


void keyPressed() {
  if (key == ENTER) {
    columns.get(0).move(50);
  }
}

void draw() {
  background(25);
  
  if (mousePressed) {
    columns.get(0).move(mouseY-columns.get(0).y);
  }
  
  for (Column i : columns) {  i.sharePos();          }
  for (Column i : columns) {  i.forces();            }
  for (Column i : columns) {  i.physics(); i.show(); }

  stroke(255);
  //line(0,height/2,width,height/2);
  
}