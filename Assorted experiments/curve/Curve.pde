Slider slider1;

ArrayList<PVector> points;

void setup() {
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  ellipseMode(CENTER);
  smooth(8);

  strokeWeight(2);    

  slider1 = new Slider("", 16, color(120, 120, 120), color(255, 255, 255), 100, new PVector(10, 10), 0.3);

  points = new ArrayList<PVector>();
  points.add(new PVector(200, 400));
  points.add(new PVector(600, 150));
  points.add(new PVector(500, 650));
}

boolean[] dragging = new boolean[3];

void draw() {
  background(25);  
  float val = slider1.slide();
  slider1.drawSlider(val);

  for (PVector p : points) {
    ellipse(p.x, p.y, 10, 10);
  }

  PVector[] weightedPoints = new PVector[2];

  int iterations = 40;
  PVector prevPoint = new PVector(points.get(2).x, points.get(2).y);
  for (float i = 0; i<iterations; i++) {
    for (int j = 0; j<2; j++) {
      PVector point = getWeightedAveragePosition(points.get(j), points.get(j+1), i/iterations);
      weightedPoints[j] = point;
    }
    PVector weightedPoint = getWeightedAveragePosition(weightedPoints[0], weightedPoints[1], i/iterations);
    stroke(255);
    line(prevPoint.x, prevPoint.y, weightedPoint.x, weightedPoint.y);
    prevPoint = new PVector(weightedPoint.x, weightedPoint.y);
  }

  for (int i = 0; i<2; i++) {
    PVector point = getWeightedAveragePosition(points.get(i), points.get(i+1), val);
    stroke(255, 0, 255);
    line(point.x, point.y, points.get(i+1).x, points.get(i+1).y);

    stroke(0, 255, 0);
    line(points.get(i).x, points.get(i).y, point.x, point.y);

    noStroke();
    fill(255, 0, 0);
    ellipse(point.x, point.y, 10, 10);

    weightedPoints[i] = point;
  }

  PVector weightedPoint = getWeightedAveragePosition(weightedPoints[0], weightedPoints[1], val);
  stroke(255, 0, 255);
  line(weightedPoint.x, weightedPoint.y, weightedPoints[1].x, weightedPoints[1].y);

  stroke(0, 255, 0);
  line(weightedPoints[0].x, weightedPoints[0].y, weightedPoint.x, weightedPoint.y);

  noStroke();
  fill(255, 0, 0);
  ellipse(weightedPoint.x, weightedPoint.y, 10, 10);

  for (int i = 0; i<points.size(); i++) {
    
    if ( abs( mouseX - points.get(i).x ) < 30) {
      if ( abs( mouseY - points.get(i).y ) < 30) {
        fill(255, 255, 255, 100);
        noStroke();
        ellipse(points.get(i).x, points.get(i).y, 60, 60);
        if (mousePressed) {
          dragging[i] = true;
          points.get(i).x = mouseX;
          points.get(i).y = mouseY;
        }
      }
    }

    if (dragging[i]) {
      points.get(i).x = mouseX;
      points.get(i).y = mouseY;
    }

    if (!mousePressed && dragging[i]) {
      dragging[i] = false;
    }
  }
}
