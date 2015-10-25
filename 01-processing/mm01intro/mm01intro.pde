/*  Processing introduction. The following program draws a 
    green ball where the X and Y mouse positions are.
    
    Author: Owen Brasier
    Date: September 2015
*/

// setup runs once just like arduino
void setup() {
  size(500, 500);                    // make a new window
  surface.setTitle("My Title!");     // set the title
}
 
// draw loops forever, just like loop from arduino
void draw() {
  background(0);                     // refresh the background to black
  fill(0, 255, 0);                   // fill all shapes and text with green
  ellipse(mouseX, mouseY, 25, 25);   // draw an ellipse where the mouse is
}