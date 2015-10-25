/* Bubbles!
  Uses the colour mixer and accelerometer vales from the Esplora to control 
  the colour and movement of the bubbles. Load the Esplora program first, 
  before you run this.
  
  Author: Owen Brasier
  Date: September 2015
  http://challenge.madmaker.com.au
*/

import processing.serial.*;                     // import the Serial library

String serial;
Serial port;

int MAXPOINTS = 255;

Bubble[] bubbles = new Bubble[MAXPOINTS];       // array of points of type bubble
int r, g, b;                                    // global variables to store values from Esplora
int xAxis, yAxis;

void setup() {
  printArray(Serial.list());                    // print the serial ports available
  String comPort = Serial.list()[0];          // this line should work on linux
  //String comPort = Serial.list()[Serial.list().length-1];        // windows and mac
  try {
    port = new Serial(this, comPort, 9600);    
  }
  catch (Exception e) {
    println(e);
    println("There was an error, please check your port and make sure the Serial Monitor is closed!");
    exit();
  }
  size(800, 600);                            // new window
  frame.setTitle("Tilt bubbles!");
  for (int i = 0; i < bubbles.length; i++)
    bubbles[i] = new Bubble();               // fill array with white bubbles
  background(210);
}

void draw() {
  while (port.available() > 0) {
    serial = port.readStringUntil('\n');
  }
  if (serial != null) {               // if string is not empty
    serial = trim(serial);            // trim any whitespace
    processEsplora();                 // process the Esplora data, do stuff!
  }
}

/**
 * Process input from the Esplora
 */
void processEsplora() {
  String[] a = split(serial, ',');    // split up line with delimiter to be ','
  try {
    r = int(a[0]);
    g = int(a[1]);
    b = int(a[2]);
    xAxis = int(a[3]);
    yAxis = int(a[4]); 
    storePoint();
    displayPoints();
  }
  catch(Exception e) {
    println(e);
    println("There was an error! Please make sure you are sending the correct data!");
    exit();
  }
}

/**
 * Display all the points, new bubbles are at the end of the array and are displayed last
 */
void displayPoints() {
  background(210);                    // clear the screen
  for(Bubble b : bubbles) {
    b.display();
    b.fade();
  }
}

/**
 * Store the new bubble at the last point in the array
 */
void storePoint() {
  shiftLeft();                                      // shift all points to the left
  bubbles[bubbles.length-1].reset(xAxis, yAxis);    // reset the last point to the current position
  bubbles[bubbles.length-1].setColour(r, g, b);
}

/**
 * Shift all bubbles to the left.
 */
void shiftLeft() {
  Bubble start = bubbles[0];
  arrayCopy(bubbles, 1, bubbles, 0, bubbles.length - 1);
  bubbles[bubbles.length - 1] = start;
}

/* This is the Bubble class, normally you would put it in a different file
   called Bubble.pde in the same folder. But to make it easier we have put
   everything in the one file
*/
class Bubble {
  float x, y;
  int r, g, b, a;
  float radius = 20;
 
  // make a new bubble
  Bubble() {
    x = 0;    // x position
    y = 0;    // y position
    a = 0;
  }

  // make more transparent
  void fade() {
      a -= 3;
      if(a <= 0)
        a = 0;
  }
  
  // display the point
  void display() {
    fill(r, g, b, a);                    // the colour, a is opacity
    noStroke();
    ellipse(x, y, radius*2, radius*2);   // draw the bubble
  }

  // set the position to the accelerometer
  void reset(int x_, int y_) {
    x = map(x_, -220, 220, width, 0);
    y = map(y_, -220, 220, 0, height);
    a = 255;
  }
  
  void setColour(int r_, int g_, int b_) {
    r = r_;
    g = g_;
    b = b_;
  }
}