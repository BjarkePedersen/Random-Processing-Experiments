
int GW = 7;
int GH = 6;

int showScale = 75;

boolean[][] drawGrid = new boolean[GW][GH];

Player p1 = new Player();
Player p2 = new Player();

void setup() {
  size(800, 800, P3D);
  pixelDensity(displayDensity());
  ellipseMode(CORNER);
  smooth(8);

  println("Loading...");
  PFont font = createFont("Arial", 32);
  textFont(font);
  textSize(32);
  println("");
  
  println("Red controls: A S D");
  println("Yellow controls: ← ↓ →");
 
}

void draw() {
  background(25);

  showBoard();
  checkWinner();
  
}