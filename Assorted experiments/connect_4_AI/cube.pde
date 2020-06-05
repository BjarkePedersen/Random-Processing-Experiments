
PGraphics cubeLayer;

//ArrayList<ArrayList<Neuron>> network = new ArrayList<ArrayList<Neuron>>();

int s = 50;

String os=System.getProperty("os.name");

boolean viewWeights = false;
boolean viewPlayer1 = true;

PVector prevMouseLoc, mouseLoc, mouseSum;

void cubeSetup() {
  mouseLoc = new PVector(0, 0);
  mouseSum = mouseLoc;

  float cameraZ = (height/2.0) / tan(PI*60/360);
  cubeLayer = createGraphics(800, 800, P3D);
}


float scroll = 3.1;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scroll += e /(os.contains("Windows") ? 25 : 1000) * s/50;
}

void drawCube() {
  cubeLayer.beginDraw();
  cubeLayer.background(25);

  cubeLayer.stroke(255);
  cubeLayer.line(0, 0, 0, height);

  cubeLayer.translate(width/4, width/4, width/scroll );

  prevMouseLoc = mouseLoc;
  mouseLoc = new PVector(mouseX, mouseY);
  PVector mouseDiff = new PVector(mouseLoc.x - prevMouseLoc.x, mouseLoc.y - prevMouseLoc.y);
  if (mousePressed)
    mouseSum = new PVector(mouseSum.x + mouseDiff.x, mouseSum.y + mouseDiff.y);

  if (mouseSum.y > PI / 2 * 200) mouseSum.y = PI / 2 * 200;
  if (mouseSum.y < - PI / 2 * 200) mouseSum.y = - PI / 2 * 200;
  cubeLayer.rotateX(-mouseSum.y / 200);
  cubeLayer.rotateY(mouseSum.x / 200);

  cubeLayer.strokeWeight(0.2);

  // Show viewing player color
  cubeLayer.fill(viewPlayer1 ? p1Color : p2Color);
  cubeLayer.noStroke();
  cubeLayer.ellipse(-s, -s, 10, 10);

  cubeLayer.fill(255);
  for (int i=0; i<AI1.neurons.length; i++) {
    randomSeed(i*12+33);
    int l = ceil(sqrt(AI1.neurons[i].length));
    //if (i==0) l = ceil(sqrt(AI1.neurons[i].length/2));
    int z = i * s*2 / (AI1.neurons.length - 1) ;
    int z1 = - s*2 / (AI1.neurons.length - 1) ;
    cubeLayer.translate(-s, -s, -s + z);

    colorMode(HSB);

    for (int j=0; j<AI1.neurons[i].length; j++) {
      int x = j%l * s*2 / l + s*2 / 2 / l ;
      int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);
      if (i == AI1.neurons.length-1) {
        // Custom placement for outputs
        x = (j+1) * s*2 / ( AI1.getOutput().length + 1 );
        y = s;
      }

      if (i > 0) {
        int l1 = ceil(sqrt(AI1.neurons[i-1].length));
        for (int k=0; k<AI1.weights[i][j].length; k++) {
          int x1 = k%l1 * s*2 / l1 + s*2 / 2 / l1 ;
          int y1 = (k / l1) %l1 * s*2 / (l1) + s*2 / 2 / (l1-1);
          if (!viewWeights) {
            float stroke = map(abs(viewPlayer1 ? AI1.connections[i][j][k] : AI2.connections[i][j][k]), 0, 1, 0, 255);
            cubeLayer.stroke(stroke, stroke);
            if (stroke < 1) cubeLayer.noStroke();
          } else {
            float val = map(abs(viewPlayer1 ? AI1.weights[i][j][k] : AI2.weights[i][j][k]), 0, 1, 0, 255)/100;
            val = val > 100 ? val = 100 : val;
            color stroke = color(val, 255, 255);
            cubeLayer.stroke(stroke);
          }
          cubeLayer.line(x, y, 0, x1, y1, z1);
        }
      }
    }

    colorMode(RGB);

    cubeLayer.stroke(255);
    if (i == 0) {
      for (int j=0; j<AI1.neurons[i].length; j++) {
        int x = j%l * s*2 / l + s*2 / 2 / l ;
        int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);
        float fill = abs(map(AI1.neurons[i][j], 0, 1, 0, 255));
        cubeLayer.fill(fill, 255);
        cubeLayer.rect(x - s/50, y - s/50, 2 * s/50, 2* s/50);
      }
      //for (int j=AI1.neurons[i].length/2; j<AI1.neurons[i].length; j++) {
      //  int x = j%l * s*2 / l + s*2 / 2 / l ;
      //  int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);
      //  float fill = abs(map(AI1.neurons[i][j], 0, 1, 0, 255));
      //  cubeLayer.fill(fill, 255);
      //  cubeLayer.rect(x - s/50, y - s/50, 2 * s/50, 2* s/50);
      //}
    }
    if (i == AI1.weights.length - 1) {
      for (int j=0; j<AI1.neurons[i].length; j++) {
        //int x = j%l * s*2 / l + s*2 / 2 / l ;
        //int y = (j / l) %l * s*2 / (l) + s*2 / 2 / (l-1);

        // Custom placement for outputs
        int x = (j+1) * s*2 / ( AI1.getOutput().length + 1 );
        int y = s;
        float fill = abs(map(AI1.neurons[i][j], 0, 1, 0, 255));
        cubeLayer.fill(fill);
        if (j == getChoice(AI1.getOutput())) {
          cubeLayer.fill(255, 0, 0);
        }
        cubeLayer.rect(x - s/50, y - s/50, 2 * s/50, 2* s/50 );
      }
    }    
    cubeLayer.translate(s, s, s - z);
  }
  cubeLayer.noFill();

  cubeLayer.strokeWeight(4);
  cubeLayer.stroke(255);

  cubeLayer.beginShape();
  cubeLayer.vertex(-s, -s, -s);
  cubeLayer.vertex(s, -s, -s);
  cubeLayer.vertex(s, s, -s);
  cubeLayer.vertex(-s, s, -s);
  cubeLayer.endShape();

  cubeLayer.beginShape();
  cubeLayer.vertex(-s, -s, s);
  cubeLayer.vertex(-s, -s, -s);
  cubeLayer.vertex(-s, s, -s);
  cubeLayer.vertex(-s, s, s);
  cubeLayer.endShape();

  cubeLayer.beginShape();
  cubeLayer.vertex(s, s, s);
  cubeLayer.vertex(-s, s, s);
  cubeLayer.vertex(-s, -s, s);
  cubeLayer.vertex(s, -s, s);
  cubeLayer.endShape();

  cubeLayer.beginShape();
  cubeLayer.vertex(s, s, -s);
  cubeLayer.vertex(s, s, s);
  cubeLayer.vertex(s, -s, s);
  cubeLayer.vertex(s, -s, -s);
  cubeLayer.endShape();

  cubeLayer.strokeWeight(5);
  s -= 1;
  cubeLayer.stroke(255, 0, 0);
  cubeLayer.line(-s, -s, -s, -s + 15, -s, -s);
  cubeLayer.stroke(0, 255, 0);
  cubeLayer.line(-s, -s, -s, -s, -s + 15, -s);
  cubeLayer.stroke(0, 0, 255);
  cubeLayer.line(-s, -s, -s, -s, -s, -s + 15);
  s += 1;


  cubeLayer.endDraw();
  image(cubeLayer, 800, 0);
}
