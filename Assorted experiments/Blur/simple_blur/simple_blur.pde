int size = 64;
int scale = 10;
float[][] img = new float[size][size];
float[][] result = new float[size][size];

//float[][] kernel = {{-1,.5,2},
//                    {-1,.5,2},
//                    {-1,.5,2}};

int kSize = 3;
float[][] kernel = kernel(kSize);

int kView = 0;

void setup() {
  background(255);
  size(0, 9);
  surface.setSize(size*scale, size*scale);
  assignVals();

  printCtrls();

  // Blur image
  blurImg();
}

void printCtrls() {
  println("");
  println("UP / DOWN: change kernel size");
  println("ENTER: View kernel");
  println("");
}

// Draw original image
void drawImg() {
  int x = 0;
  int y = 0;

  noStroke();
  for (float[] i : img) {
    for (float f : i) {
      fill(map(f, 0, 1, 0, 255));
      rect(scale*x, scale*y, scale, scale);
      x++;
    }
    x = 0;
    y++;
  }
}

// Draw blurred image
void drawResult() {
  int x = 0;
  int y = 0;

  noStroke();
  for (float[] i : result) {
    for (float f : i) {
      fill(map(f, 0, 1, 0, 255));
      rect(scale*x, scale*y, scale, scale);
      x++;
    }
    x = 0;
    y++;
  }
}

void drawKernel() {
  background(0);
  int x = 0;
  int y = 0;
  // For each value in kernel
  for (float[] i : kernel) {
    for (float kernelVal : i) {
      fill(map(kernelVal, 0, .4, 0, 255));
      stroke(30);
      rect(scale*x, scale*y, scale, scale);
      x++;
    }
    x = 0;
    y++;
  }
}

// switch view
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      kSize += 2;
      kernel = kernel(kSize);
      blurImg();
      printCtrls();
      println("kernel size:", kSize);
    }
  }
  if (key == CODED) {
    if (keyCode == DOWN) {
      kSize -= 2;
      if (kSize < 3) {
        kSize = 3;  // Kernel size shouldn't be less than 3
      }
      kernel = kernel(kSize);
      blurImg();
      printCtrls();
      println("kernel size:", kSize);
    }
  }
  // Switch kernel view
  if (key == ENTER) {
    kView = abs(kView -1);
  }
}

void draw() {
  if (kView == 1) {
    drawKernel();
  }else{
    drawResult();
  }
}