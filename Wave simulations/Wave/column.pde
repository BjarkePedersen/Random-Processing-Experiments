
public class Column {
  int ID;

  float y = height/2 + random(-1,1);
  float acc = 0;
  float vel = 0;
  float speed = 1;
  float damp = 0.98;

  public Column(int ID) {
    this.ID = ID;
  }

  void sharePos() {
    positions[ID] = y;
  }
  
  void forces() {
    if (ID != 0 && ID != num-1) {
      acc = (positions[ID-1]+positions[ID+1])/2 - y;
    } else if (ID == 0) {
      acc = (positions[ID+1] - y)/2;
    } else if (ID == num-1) {
      acc = (positions[ID-1] - y)/2;
    }
  }

  void physics() {
    acc *= speed;
    vel += acc;
    vel *= damp;
    y += vel;
  }

  void move(float in) {
    vel = in;
  }

  void show() {
    fill(60, 180, 200);
    stroke(25);
    float gap = 100;
    float w = ((width-gap)/num);
    rect(w*this.ID+gap/2, height, w, -y);
  }
}