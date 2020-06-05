
//Neuron[][] network = new Neuron[4][12];

ArrayList<ArrayList<Neuron>> network = new ArrayList<ArrayList<Neuron>>();

int s = 50;

class Neuron {
  int index, layer;
  public Neuron(int index, int layer) {
    this.index = index;
    this.layer = layer;
  }
}

PVector prevMouseLoc, mouseLoc, mouseSum;

void setup() {
  size(800, 800, P3D);
  pixelDensity(displayDensity());
  smooth(8);
  rectMode(CENTER);
  stroke(255);
  strokeWeight(4);
  noFill();

  for (int i=0; i<5; i++) {
    network.add(new ArrayList<Neuron>());
  }
  for (int i=network.size()-1; i>=0; i--) {
    for (int j=0; j<2+i*i*3; j++) {
      network.get(network.size()-1-i).add(new Neuron(j, i));
    }
  }

  mouseLoc = new PVector(0,0);
  mouseSum = mouseLoc;
}

float scroll = 1.5;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scroll += e /1000 * s/50;
}

void draw() {
  background(25);
  translate(width/2, width/2, width/scroll );
  
  prevMouseLoc = mouseLoc;
  mouseLoc = new PVector(mouseX, mouseY);
  PVector mouseDiff = new PVector(mouseLoc.x - prevMouseLoc.x, mouseLoc.y - prevMouseLoc.y);
  if (mousePressed)
    mouseSum = new PVector(mouseSum.x + mouseDiff.x, mouseSum.y + mouseDiff.y);
  
  if (mouseSum.y > PI / 2 * 200) mouseSum.y = PI / 2 * 200;
  if (mouseSum.y < - PI / 2 * 200) mouseSum.y = - PI / 2 * 200;
  rotateX(-mouseSum.y / 200);
  rotateY(mouseSum.x / 200);

  strokeWeight(0.2);

  fill(255);
  for (int i=0; i<network.size(); i++) {
    randomSeed(i*12+33);
    int l = ceil(sqrt(network.get(i).size()));
    int z = i * s*2 / (network.size() - 1) ;
    int z1 = s*2 / (network.size() - 1) ;
    translate(-s, -s, -s + z);
    stroke(255);
    for (int j=0; j<network.get(i).size(); j++) {
      int x = j%l * s*2 / l + s*2 / 2 / l ;
      int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);

      if (i+1 < network.size()) {
        int l1 = ceil(sqrt(network.get(i+1).size()));
        for (int k=0; k<network.get(i+1).size(); k++) {
          int x1 = k%l1 * s*2 / l1 + s*2 / 2 / l1 ;
          int y1 = (k / l1) %l1 * s*2 / (l1) + s*2 / 2 / (l1-1);
          line(x, y, 0, x1, y1, z1);
        }
      }
    }
    noStroke();
    if (i == 0) {
      for (int j=0; j<network.get(i).size(); j++) {
        int x = j%l * s*2 / l + s*2 / 2 / l ;
        int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);
        rect(x, y, 2 * s/50, 2* s/50);
      }
    }
    if (i == network.size() - 1) {
      for (int j=0; j<network.get(i).size(); j++) {
        int x = j%l * s*2 / l + s*2 / 2 / l ;
        int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);
        rect(x, y, 2 * s/50, 2* s/50 );
      }
    }    
    translate(s, s, s - z);
  }
  noFill();

  strokeWeight(4);
  stroke(255);

  beginShape();
  vertex(-s, -s, -s);
  vertex(s, -s, -s);
  vertex(s, s, -s);
  vertex(-s, s, -s);
  endShape();

  beginShape();
  vertex(-s, -s, s);
  vertex(-s, -s, -s);
  vertex(-s, s, -s);
  vertex(-s, s, s);
  endShape();

  beginShape();
  vertex(s, s, s);
  vertex(-s, s, s);
  vertex(-s, -s, s);
  vertex(s, -s, s);
  endShape();

  beginShape();
  vertex(s, s, -s);
  vertex(s, s, s);
  vertex(s, -s, s);
  vertex(s, -s, -s);
  endShape();
  
  strokeWeight(5);
  s -= 1;
  stroke(255,0,0);
  line(-s,-s,-s,-s + 15,-s,-s);
  stroke(0,255,0);
  line(-s,-s,-s,-s ,-s + 15,-s);
  stroke(0,0,255);
  line(-s,-s,-s,-s,-s,-s + 15);
  s += 1;
}