/*  Bouncing ball in two dimensions. Modify the program below
    so the ball bounces off the top edge, as well and the side
    edges like our last program.
    
    Author: Owen Brasier
    Date: September 2015
*/

int x = 0;                              // starting position of x
int y = 0;
int speedx = 2;                          // how far we move each frame
int speedy = 3;
 
void setup() {
  size(400, 400);                       // make a window
  fill(255, 0, 0);                      // make the ball red (r, g, b)
}
 
void draw() {
  background(0);                        // set the background black
  x = x + speedx;                       // move the ball across
  // move y here
  if (/* SOME CONDITION */) {
    // reverse x direction
  }
  if ( /* OTHER CONDITION */) {
    // reverse y direction 
  }
  ellipse(x, height/2, 25, 25);         // you might need to change this line...
}