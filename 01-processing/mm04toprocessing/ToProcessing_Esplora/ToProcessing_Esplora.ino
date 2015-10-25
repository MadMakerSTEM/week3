/*  To Processing Program, sends data to Processing
 *  over the serial port every half second
 *  
 *  http://challenge.madmaker.com.au
 *  Author: Owen Brasier
 *  Date: September 2015
 */


int value = 0;                  // set global integer value to 0
 
void setup() {
  Serial.begin(9600);           // initialise serial communication
}
 
void loop() {
  Serial.println(value);        // print value with a newline after it
  value++;                      // increment value
  delay(500);                   // wait half a second
}
