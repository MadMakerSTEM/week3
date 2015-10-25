/*  Reading data from the Serial port. 

    Author: Owen Brasier
    Date: September 2015
    http://challenge.madmaker.com.au
*/


import processing.serial.*;           // import the Serial library

String serial = "waiting...";
Serial port;
int lf = 10;

void setup() {
  printArray(Serial.list());             // print the serial ports available
  size(200, 200);                        // new window
  frame.setTitle("Numbers!");            // set the title
  textSize(26);
  textAlign(CENTER);  
  //String comPort = Serial.list()[0];  // linux usually use the first port in the list
  String comPort = Serial.list()[Serial.list().length-1];  // windows - get the last one
  try {
    port = new Serial(this, comPort, 9600);
  }
  catch (Exception e) {
    println(e);
    exit();
  }
  port.bufferUntil(lf);
}

void draw() {
  background(0);                    // clear the screen
  translate(width/2, height/2);     // set the origin to be in the middle
  text(serial, 0, 0);               // print the text in the center of the screen
}

void serialEvent(Serial p) { 
  serial = p.readString();
} 