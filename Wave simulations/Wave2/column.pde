
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
    if (ID != 0 && ID != num-1 && ID != 1 && ID != num-2) {
      y = (positions[ID-2]+positions[ID-1]+positions[ID+1]+positions[ID+2])/4;
    } else if (ID == 0) {
      y = (positions[ID+1]+positions[ID+2]+positions[ID]*2)/4;
    } else if (ID == 1) {
      y = (positions[ID-1]+positions[ID-1]+positions[ID+1]+positions[ID+2])/4;
    } else if (ID == num-1) {
      y = (positions[ID-1]+positions[ID-2]+positions[ID]*2)/4;
    } else if (ID == num-2) {
       y = (positions[ID-1]+positions[ID-2]+positions[ID+1]+positions[ID+1])/4;
    }
  }
  

  void move(float in) {
    y = in;
  }

  void show() {
    float gap = 100;
    float w = ((width-gap)/num);
    rect(w*this.ID+gap/2, height, w, -y);
  }
}