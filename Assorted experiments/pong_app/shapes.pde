PShape ball, playArea, p1s, p2s, hamburger, pauseOverlay, playerSelect, pauseShape, arrowLeft, arrowRight;

Ball ball1;
Player p1, p2;
ArrayList<Player> players = new ArrayList<Player>();

// Ball diameter
float bd;

void createShapes() {
  bd = hp(4);

  ball1 = new Ball(new PVector(width/2, height/2));

  p1 = new Player(new PVector(width-hp(15), height/2));
  players.add(p1);
  if (playerCount == 2) { 
    p2 = new Player(new PVector(hp(15), height/2)); 
    players.add(p2);
  }


  ball = createShape(ELLIPSE, 0, 0, bd, bd);
  ball.setFill(col1);
  ball.setStroke(false);

  hamburger = createShape(GROUP);
  PShape upperBun = createShape(RECT, 0, hp(-3), hp(9), hp(1.5), hp(1.5));
  PShape patty = createShape(RECT, 0, 0, hp(9), hp(1.5), hp(1.5));
  PShape lowerBun = createShape(RECT, 0, hp(3), hp(9), hp(1.5), hp(1.5));
  hamburger.addChild(upperBun);
  hamburger.addChild(patty);
  hamburger.addChild(lowerBun);
  hamburger.setFill(col1);

  pauseOverlay = createShape(RECT, 0, 0, width, height);
  pauseOverlay.setFill(color(col1, 200));

  playerSelect = createShape(GROUP);
  PShape head = createShape(ELLIPSE, -hp(3), 0, hp(4), hp(4));
  PShape torso = createShape(RECT, -hp(3), hp(5), hp(6), hp(4), hp(6), hp(6), 0, 0);
  playerSelect.addChild(head);
  playerSelect.addChild(torso);
  playerSelect.setFill(col2);

  arrowLeft = createShape(GROUP);
  PShape shaft = createShape(RECT, -0.2, 0, 9.9, 1.5, 1.5);
  PShape upperHead = createShape(RECT, 0, 0, 5, 1.5, 1.5);
  upperHead.rotate(PI/4);
  upperHead.translate(-3, 1.5);
  PShape lowerHead = createShape(RECT, 0, 0, 5, 1.5, 1.5);
  lowerHead.rotate(-PI/4);
  lowerHead.translate(-3, -1.5);
  arrowLeft.addChild(shaft);
  arrowLeft.addChild(upperHead);
  arrowLeft.addChild(lowerHead);
  arrowLeft.setFill(col2);
  arrowLeft.scale(dip(0.8));

  arrowRight = createShape(GROUP);
  PShape shaft2 = createShape(RECT, -0.2, 0, 9.9, 1.5, 1.5);
  PShape upperHead2 = createShape(RECT, 0, 0, 5, 1.5, 1.5);
  upperHead2.rotate(-PI/4);
  upperHead2.translate(2.6, 1.5);
  PShape lowerHead2 = createShape(RECT, 0, 0, 5, 1.5, 1.5);
  lowerHead2.rotate(PI/4);
  lowerHead2.translate(2.6, -1.5);
  arrowRight.addChild(shaft2);
  arrowRight.addChild(upperHead2);
  arrowRight.addChild(lowerHead2);
  arrowRight.setFill(col2);
  arrowRight.scale(dip(0.8));
}

public class Ball {
  PVector pos, prevPos, vel;

  public Ball(PVector pos) {
    this.pos = pos;
    prevPos = new PVector(pos.x, pos.y);
    if (playerCount == 2) vel = new PVector(hp(1)-hp(2*round(random(0, 1))), 0);
    else vel = new PVector(hp(-1), 0);
  }

  void collide() {
    if (pos.x + bd/2 >= width) {
      pos.x = width-bd/2;
      //vel.x *= -1;
      vel.y = 0;
      winner = p2;
    }
    if (pos.x - bd/2 <= 0) {
      pos.x = bd/2;
      if (playerCount == 1) {
        p1.score++;
        if (p1.score > soloHighScore) soloHighScore = p1.score;
        vel.x *= -1.0; 
        vel.y = random(-hp(2), hp(2));
      } else { 
        winner = p1;
        vel.y = 0;
      }
    }
    if (pos.y - bd/2 <= 0) {
      pos.y = bd/2;
      vel.y *= -1;
    }
    if (pos.y + bd/2 >= height) {
      pos.y = height - bd/2;
      vel.y *= -1;
    }

    for (Player player : players) {
      float pw = player.w;
      float hp = player.h;
      PVector pPos = new PVector(player.pos.x, player.pos.y);
      if (pos.x + bd/2 > pPos.x - pw/2) {
        if (pos.x - bd/2 < pPos.x + pw/2) {
          if (pos.y + bd/2 > pPos.y - hp/2) {
            if (pos.y - bd/2 < pPos.y + hp/2) {
              pos.x = vel.x < 0 ? pPos.x + pw/2 + bd/2 : pPos.x - pw/2 - bd/2;
              vel.x *= -1;
              vel.x += vel.x > 0 ? hp(0.05) : -hp(0.05);

              // Hit corners
              float x = -(pos.y - pPos.y); 
              x /= hp/2 + bd/2; 
              x *= -1;
              float y = hp((x > 0 ? 1 : -1) * (pow(abs(x), 10 - abs(x)*10)));
              y += player.vel.y / 5;
              if (abs(x) > 0.7) vel.y = y;
              else vel.y += y;
            }
          }
        }
      }
    }
  }

  void move() {
    prevPos.x = pos.x;
    prevPos.y = pos.y;
    pos.add(vel);
    collide();
  }

  void show() {
    shape(ball, pos.x, pos.y);
    //PVector futurePos = futurePos();
    PVector futurePos = futureCollide();
    println(futurePos.x, futurePos.y);
    ellipse(futurePos.x, futurePos.y, 10, 10);
  }
  
  PVector futurePos() {
    float a = vel.y / vel.x;
    float b = pos.y;
    stroke(255, 0, 0);
    //line(pos.x, pos.y, pos.x -pos.y/a, 0);
    line(pos.x, pos.y, pos.x -pos.y/a, 0);
    stroke(0, 255, 0);
    line(pos.x, pos.y, pos.x + (height-pos.y)/a, height);
    float x;
    float y;
    if (vel.y < 0) {
      x = pos.x -pos.y/a;
      y = 0;
    }
    else if (vel.y > 0) {
      x = pos.x + (height-pos.y)/a;
      y = height;
    }
    else {
      x = width/2;
      y = height/2;
    }
    return new PVector(x, y);
  }
  PVector futureCollide() {
    PVector position = futurePos();
    float a = 1*vel.y / -vel.x;
    float b = position.y;
    stroke(255, 0, 255);
    line(position.x, position.y, hp(15), a*hp(15)+b);
    //stroke(0, 255, 0);
    //line(position.x, position.y, position.x + (height-position.y)/a, height);
    float x;
    float y;
    //if (vel.y < 0) {
      x = hp(15);
      y = a*hp(15)+b;
    //}
    //else if (vel.y > 0) {
    //  x = position.x + (height-position.y)/a;
    //  y = height;
    //}
    //else {
    //  x = width/2;
    //  y = height/2;
    //}
    return new PVector(x, y);
  }
}



public class Player {
  PVector pos, vel;
  int score = 0;
  PShape playerShape;
  float w, h;

  public Player(PVector pos) {
    this.pos = pos;
    h = hp(20);
    w = hp(3);
    playerShape = createShape(RECT, 0, 0, w, h, hp(3));
    playerShape.setFill(col1);
    playerShape.setStroke(false);
  }

  void move() {
    PVector prevPos = new PVector(pos.x, pos.y);
    vel = new PVector(pos.x-prevPos.x, pos.y-prevPos.y);
    if (mousePressed) {
      // DIRECT CONTROL
      //for (int i=0; i<touches.length; i++) {
      //  if (mag(touches[i].x-pos.x, touches[i].y-pos.y) < h+hp(5)) {
      //    pos.y = touches[i].y;
      //  }
      //}

      // CLAMPED CONTROL 
      for (int i=0; i<touches.length; i++) {
        if (abs(touches[i].x-pos.x) < h+hp(5)) {
          vel.y = touches[i].y - pos.y;
        }
      }
      float max = hp(2);
      vel.y = vel.y > max ? max : vel.y;
      vel.y = vel.y < -max ? -max : vel.y;
      pos.y += vel.y;


      if (pos.y + h/2 > height) {
        pos.y = height - h/2;
      }
      if (pos.y - h/2 < 0) {
        pos.y = h/2;
      }
    }
  }

  void show() {
    shape(playerShape, pos.x, pos.y);
  }
}
