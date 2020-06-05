
public class Button {
  PVector pos;
  PShape shape;
  float diameter;
  Runnable action;

  public Button(PVector pos, PShape shape, Runnable action) {
    this.pos = pos;
    this.action = action;
    this.shape = shape;
    diameter = hp(15);
  }

  void callAction() {
    action.run();
  }


  boolean prevTouch;
  boolean touched;
  boolean touch() {
    for (int i=0; i<touches.length; i++) {
      if (mag(touches[i].x-pos.x, touches[i].y-pos.y) < diameter) {
        return true;
      }
    }
    return false;
  }

  void checkClick () {
    prevTouch = touched;
    touched = touch();

    if (prevTouch && !touched) {
      callAction();
    }
  }

  void show() {
    shape(shape, pos.x, pos.y);
  }
}

Runnable button1Action = new Runnable() {
  void run() {
    changePause();
  }
};

Runnable select1Player = new Runnable() {
  void run() {
    players = new ArrayList<Player>();
    p1 = new Player(new PVector(width-hp(15), height/2));
    p2 = new Player(new PVector(hp(15), height/2)); 
    players.add(p1);
    players.add(p2);
    ball1 = new Ball(new PVector(width/2, height/2));
    playerCount = 1;
    players.remove(1);
    startUp = false;
    beginApp = false;
  }
};

Runnable select2Player = new Runnable() {
  void run() {
    players = new ArrayList<Player>();
    p1 = new Player(new PVector(width-hp(15), height/2));
    p2 = new Player(new PVector(hp(15), height/2)); 
    players.add(p1);
    players.add(p2);
    ball1 = new Ball(new PVector(width/2, height/2));
    playerCount = 2;
    startUp = false;
    beginApp = false;
  }
};

Runnable homeAction = new Runnable() {
  void run() {
    startUp = true;
    changePause();
    pause = true;
    countdown = 180;
  }
};

Runnable returnAction = new Runnable() {
  void run() {
    startUp = false;
    pause = false;
    changePause();
    pause = true;
    countdown = -1;
  }
};


Button button1, select1p, select2p, home, returnBtn;

void initializeButtons() {
  button1 = new Button(new PVector(width/2, hp(10)), hamburger, button1Action);
  select1p = new Button(new PVector(width/2-hp(20), height/2), new PShape(), select1Player);
  select2p = new Button(new PVector(width/2+hp(20), height/2), new PShape(), select2Player);
  home = new Button(new PVector(wp(10), hp(10)), arrowLeft, homeAction);
  returnBtn = new Button(new PVector(width-wp(10), hp(10)), arrowRight, returnAction);
}
