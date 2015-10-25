/* Colour Mixer

Description: Mixes different levels of red green and blue, 
by holding down the down, left, up button respectively. The 
slider is used to alter the intensity of the selected colour. 
The RGB levels are displayed on the Esplora's RGB LED,
as well via serial communication for its companion Processing 
sketch to display.

Author: Calla Klafas
Date: August 2015

http://challenge.madmaker.com.au
*/

#include <Esplora.h>

// start off with no value
int red = 0;
int green = 0;
int blue = 0;

void setup() {
  Serial.begin(9600); 
}

void loop() { //Main loop
  showColour(); 
  printColour(); //Output these values to USB serial for other programs to interpret
  printAccelerometer();
}

void printColour(){ //prints the colour stored to the Serial Monitor
  Serial.print(red);
  Serial.print(",");
  Serial.print(green);
  Serial.print(",");
  Serial.print(blue);
  Serial.print(",");
}

void printAccelerometer(){ 
  int xAxis = Esplora.readAccelerometer(X_AXIS);
  int yAxis = Esplora.readAccelerometer(Y_AXIS);
  Serial.print(xAxis);
  Serial.print(',');
  Serial.println(yAxis);
}

void showColour(){
    int sliderPosition = Esplora.readSlider();
    byte brightness = map(sliderPosition, 0, 1024, 0, 255); //rescale the slider's value to the range of the LEDs. 
      if (Esplora.readButton(SWITCH_DOWN) == LOW) {
        red = brightness;
      }
      else if(Esplora.readButton(SWITCH_LEFT) == LOW){
        green = brightness;
      }
      else if(Esplora.readButton(SWITCH_UP) == LOW){
        blue = brightness;
      }
    Esplora.writeRGB(red,green,blue);
}
