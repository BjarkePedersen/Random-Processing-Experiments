
int GW = 7;
int GH = 6;

int showScale = 75;

boolean[][] drawGrid = new boolean[GW][GH];

Player p1 = new Player();
Player p2 = new Player();

void setup() {
  randomSeed(1);
  
  size(1600, 800, P2D);
  pixelDensity(displayDensity());
  ellipseMode(CORNER);
  smooth(8);

  println("Loading font...");
  PFont font = createFont("Arial", 32);
  textFont(font);
  textSize(32);
  println("");
  
  println("SPACE: Toggle 'view weights'");
  println("P: Switch player view");
  println("BACKSPACE: Stop training");
  
  initializeAI();
  cubeSetup();
  
  thread("thread1");
}

void draw() {
  background(25);

  drawCube();
  showBoard();
  if (!auto) checkWinner();
  
}
