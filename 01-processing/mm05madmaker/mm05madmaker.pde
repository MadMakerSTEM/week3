/* MadMaker Face
   
   Below is an example of how you would make the MadMaker face in Processing.
   
   The face is a grid of 14 pixels separation between each LED feature.
   
   Press 'b' to make him blink.
   
   Author: Owen Brasier
   Date: September 2015
*/

int radius = 60;            //radius of the eyes
boolean blink = false;

void setup() {
  size(392, 392);
  drawFace();
}

void draw() {
  if (blink && frameCount % 4 == 0)
    blink();
}

void keyPressed() {
  if (key == 'b' || key == 'B')
    blink = true;
}

int b = 1;
// blink only closes. Maybe you could get it to open as well...
void blink() {
  fill(0);                            // fill with black
  for (int i = 1; i <= b; i ++) {
    rect(60, 77, 310, (i*14));        // cover eyes with rectangle going down
    rect(60, 203, 310, -(i*14));      // ...and up.
  }
  b++;
  if (b == 6) {                       // reset when it's done.
    b = 1;
    blink = false;
    drawFace();
  }
}

void drawFace() {
  background(255);
  fill(0);
  ellipse(width/2, height/2, 392, 600);
  drawEyes();
  drawNose();
  drawMouth();
  drawEyebrows();
}

void drawEyes() {
  fill(52, 122, 255);
  for (int x = 0; x < width; x+=14) {
    for (int y = 0; y < height; y += 14) {
      if (sq(x - 126) + sq(y - 140) <= sq(radius)) // if point is inside left circle
        ellipse(x, y, 10, 10);
      if (sq(x - 280) + sq(y - 140) <= sq(radius)) // if point inside right circle
        ellipse(x, y, 10, 10);
    }
  }
}

// Eyebrows has a lot of circles...
void drawEyebrows() {
  fill(52, 122, 255);
  ellipse(70, 70, 10, 10);
  ellipse(84, 56, 10, 10);
  ellipse(98, 56, 10, 10);
  ellipse(112, 42, 10, 10);
  ellipse(126, 42, 10, 10);
  ellipse(140, 42, 10, 10);
  ellipse(154, 56, 10, 10);
  ellipse(168, 56, 10, 10);
  ellipse(238, 56, 10, 10);
  ellipse(252, 56, 10, 10);
  ellipse(266, 42, 10, 10);
  ellipse(280, 42, 10, 10);
  ellipse(294, 42, 10, 10);
  ellipse(308, 56, 10, 10);
  ellipse(322, 56, 10, 10);
  ellipse(336, 70, 10, 10);
}

void drawNose() {
  fill(52, 122, 255);
  ellipse(196, 238, 10, 10);
  ellipse(210, 238, 10, 10);
}

void drawMouth() {
  fill(52, 122, 255);
  ellipse(140, 294, 10, 10);
  ellipse(154, 294, 10, 10);
  ellipse(252, 294, 10, 10);
  ellipse(266, 294, 10, 10);
  for (int i = 154; i <= 252; i += 14)  // second row
    ellipse(i, 308, 10, 10);
  for (int j = 184; j <= 226; j += 14)  // third row
    ellipse(j, 322, 10, 10);
}