Table tsv;

void setup() {
  fullScreen(P2D);
  orientation(LANDSCAPE);    
  noStroke();
  rectMode(CENTER);
  ellipseMode(CENTER);
  //smooth();
  textSize(hp(10));

  createShapes();
  initializeButtons();

  try {                                                   
    tsv = new Table(new File(sketchPath("")+"data.tsv"));
  } 
  catch (Exception e) {  
    tsv = new Table();
    String[] data = { 
      Integer.toString(0), 
    };
    tsv.addRow();                                         
    tsv.setRow(tsv.getRowCount()-1, data);
    try {
      tsv.save(new File(sketchPath("")+"data.tsv"), "tsv");
    }
    catch(IOException iox) {
      println("Failed to write file." + iox.getMessage());
    }
  }
  for (int row = 1; row < tsv.getRowCount(); row++) {
    soloHighScore = tsv.getInt(row, 0);
  }
}

void saveHighScore() {
  String[] data = { 
    Integer.toString(soloHighScore), 
  };
  tsv.addRow();                                         
  tsv.setRow(tsv.getRowCount()-1, data);

  try {
    tsv.save(new File(sketchPath("")+"data.tsv"), "tsv");
  }
  catch(IOException iox) {
    println("Failed to write file." + iox.getMessage());
  }
}


void draw() {
  if (startUp) {
    background(col1);
    fill(255);
    textAlign(CENTER);
    text("Simple Pong", width/2, height/4);
    shape(playerSelect, width/2-hp(20), height/2);
    shape(playerSelect, width/2+hp(20), height/2);
    shape(playerSelect, width/2+hp(28), height/2);
    if (!beginApp) {
      returnBtn.checkClick();
      returnBtn.show();
    }
    select1p.checkClick();
    select2p.checkClick();
  } else {
    if (countdown < 0 && winner == null) button1.checkClick();
    if (!pause) {
      main();
    }

    background(col2);
    stroke(pause ? col1 : 180);
    line(width/2, hp(20), width/2, height);

    for (Player p : players) p.show();


    showScore();
    ball1.show();


    if (countdown > 0) countdown();
    if (countdown == 0) { 
      countdown--; 
      pause = false;
    }

    if (pause) { 
      shape(pauseOverlay, width/2, height/2);
      if (fullPause) {
        home.checkClick();
        home.show();
      }
    }

    button1.show();

    if (winner != null) showWinner();
  }
}
