/* Bouncing ball template for you to modify.
   Change the code below to bouce off the wall when it
   hits either of the sides.

   Author: Owen Brasier
   Date: September 2015
*/

int x = 0;                              // starting position of x
int speedx = 2;                          // how far we move each frame
 
void setup() {
  size(400, 400);                       // make a window
  fill(255, 0, 0);                      // make the ball red (r, g, b)
}
 
void draw() {
  background(0);                        // set the background black
  x = x + speedx;                        // move the ball across
  ellipse(x, height/2, 25, 25);         // draw the ball (x, y, width, height)
}