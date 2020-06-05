
public class Cell {
  int[] ID = new int[2];

  float y = 0;
  float acc = 0;
  float vel = 0;
  float speed = 1;
  float damp = 0.98;

  public Cell(int[] ID) {
    this.ID = ID;
    
    if (ID[0] == 0 || ID[0] == size-1)
      y = 0;
    if (ID[1] == 0 || ID[1] == size-1)
      y = 0;
  }

  void sharePos() {
    vals[ ID[0] ][ ID[1] ] = y;
  }

  void forces() {
    if (ID[0] != 0 && ID[0] != size-1) {
      if (ID[1] != 0 && ID[1] != size-1) {
        float eh = 0.43; // Eh is the best!
        acc = 0;
        acc += vals[ ID[0]-1][ID[1]  ] + vals[ ID[0]+1][ID[1]  ];
        acc += vals[ ID[0]  ][ID[1]-1] + vals[ ID[0]  ][ID[1]+1];
        
        acc += vals[ ID[0]-1][ID[1]-1] * eh + vals[ ID[0]+1][ID[1]+1] * eh;
        acc += vals[ ID[0]-1][ID[1]+1] * eh + vals[ ID[0]+1][ID[1]-1] * eh;
        acc /= 2 + 2*eh;
        acc -= y*2;
      }
    } else if (ID[0] == 0) {
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
    square.setFill(color( map(y, -1, 1, 0, 400), 255, 255 ));
    shape(square, scale*ID[0], scale*ID[1]);
  }
}