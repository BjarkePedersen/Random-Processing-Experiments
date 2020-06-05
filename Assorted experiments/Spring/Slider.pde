public class Slider {
  float val;
  float defVal;
  float sldStart, sldEnd;
  color col1, col2;
  int w, fontSize;
  int h = 2;
  PVector o;
  String name;
  boolean clicked = false;

  public Slider(String name, int fontSize, color col1, color col2, int w, PVector o, float defVal) {
    this.col1 = col1;
    this.col2 = col2;
    this.w = w;
    this.o = o;
    this.name = name;
    this.fontSize = fontSize;
    this.defVal = defVal;
    this.val = defVal;

    this.sldStart = o.x+textWidth(name)+fontSize*2;
    this.sldEnd = o.x+textWidth(name)+fontSize*2+w;
  }

  // Update the slider and calculate slider value (val)
  public float slide() {
    if (mousePressed) {
      if (mouseX > sldStart && mouseX < sldEnd) {
        float y = o.y+1+fontSize/2;
        if (mouseY > y-12/2 && mouseY < y+12/2) {
          clicked = true;
        }
      }
    } else {
      clicked = false;
    }

    if (clicked) {
      val = (mouseX-o.x-textWidth(name)-fontSize)/w;
    }
    if (val < 0) {
      val = 0;
    }
    if (val > 1) {
      val = 1;
    }

    return val;
  }

  // Set drawVal to val if no value is given in the call
  public void drawSlider() {
    drawSlider(val);
  }

  // Draw
  public void drawSlider(float drawVal) {
    // Start translation
    pushMatrix();

    // Draw slider name
    translate(o.x+textWidth(name), o.y);
    textSize(fontSize);
    textAlign(RIGHT, TOP);
    fill(col2);
    text(name, 0, 0);
    translate(fontSize, 1 + fontSize/2);

    // Draw slider value
    textSize(fontSize*.75);
    textAlign(LEFT, CENTER);
    fill(col2);
    text(drawVal, w+12, 0);

    // Draw slider line
    noStroke();
    fill(col1);
    rect(0-12/2, -12/2+3, w+12, 6+2, 6, 6, 6, 6);

    // Draw slider handle
    translate(0, h/2);
    fill(col2);
    ellipse(val*w, 0, 12, 12);

    // Reset text align
    textSize(fontSize);
    textAlign(RIGHT, TOP);

    // Reset translation
    popMatrix();
  }
}