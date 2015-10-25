/* The Lunar Lander

   This program is to demonstrate forces such as gravity, friction and
   thrust. Calculating how those forces interact with the rocket
   ship, and then adding those forces in code.
   
   Add these to the move() function, starting at line 162.
   
   Author: Owen Brasier
   Date: August 2015
*/   


final float GRAVITY = 0.016;
final float AIR = 0.99;
final float TURN_VALUE = PI/40;
final float THRUST = 0.05;

Ship ship;
int PADWIDTH = 25;
int PADHEIGHT = 10;
float PADPOS = random(-100,100);  // position of pad
float CRASHVEL = 0.5;  // threshold for crash velocity

boolean[] keys = new boolean[4];


void setup() {
  PVector pos = new PVector(0, -height/3);
  ship = new Ship(pos, 5);
  size(400, 300);
  frame.setTitle("Lunar Lander");  //surface.setTitle() can be used in v3
}

void draw() {
  model();
  if (view() > 0) {
    delay(5);
    exit();
  }
}

// physics stuff
void model() {
  handleKeys();
  ship.move();
}

// drawing stuff
int view() {
  int lstatus = 0;
  
  background(200);
  landscape();
  translate(width/2, height/2);
  ship.draw();
  if ((lstatus = ship.landed()) > 0) {
    textSize(20);
    fill(0, 102, 153);
    textAlign(CENTER, CENTER);
    if (lstatus == 1) {
      background(0,200,0);
      text("Landed! YEAH!", 0, 0);
    }
    else {
      background(200,0,0);
      text("Crashed", 0, 0);
    }
    return 1;
  }
  return 0;
}

void landscape() {
  strokeWeight(5); stroke(255,0,0); fill(255);
  line(width/2+PADPOS-PADWIDTH, height-PADHEIGHT, width/2+PADPOS, height-PADHEIGHT);
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        keys[0] = true; 
        break;
      case LEFT:
        keys[1] = true;  break;
      case RIGHT:
        keys[2] = true; break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        keys[0] = false; break;
      case LEFT:
        keys[1] = false; break;
      case RIGHT:
        keys[2] = false; break;
    }
  }
}

void handleKeys() {
  ship.thruster = keys[0];               // thruster is on or off
  if (keys[1]) ship.turns(-TURN_VALUE);  // LEFT
  if (keys[2]) ship.turns(TURN_VALUE);   // RIGHT
}

class Ship {

  PVector pos;   // position
  float theta;   // rotation angle
  float speedx;  // speed in the x direction
  float speedy;  // speed in the y direction
  PVector[] tr;  // thruster  
  int siz;       // size
  PVector[] pt;  // shape
  boolean thruster;
  
  Ship(PVector pos, int siz) {
    this.pos = pos;
    this.siz = siz;
    //vel = new PVector(0, 0);
    speedx = 0.0;
    speedy = 0.0;
    // the ship has its nose upwards
    theta = -PI/2;
    pt = new PVector[3];
    tr = new PVector[4];
    thruster = false;
    updatePoints();
  }
   
  /*
  ** determine if we have landed, if so return whether crash or successful
  */
  int landed() {
    float l = PADPOS-PADWIDTH;
    float h = PADPOS+PADWIDTH;
    
    if (pt[1].y >= (height-2*PADHEIGHT)/2 || pt[2].y >= (height-2*PADHEIGHT)/2) {
      if (speedx > CRASHVEL || speedy > CRASHVEL || pt[1].x < l || pt[2].x > h)
        return 2;
      return 1;
    }
    return 0;
  }
  
  /**
   * display the ship on screen
   */
  void draw() {
    strokeWeight(1); stroke(0); fill(255);
    triangle(pt[0].x, pt[0].y, pt[1].x, pt[1].y, pt[2].x, pt[2].y);
    if(thruster) 
      drawThruster();
  }
  
  void move() {
    // gravity
    // friction x
    // friction y
    //if (/* THRUSTER IS ON */) {
    //  SPEED CODE GOES HERE
    //  
    //}
    bounce();
    pos.x += speedx;    // move the ship in x and y
    pos.y += speedy;    
    updatePoints();
  }
  
  /* Note the origin (0, 0) is the center of the screen
     So the top has a y value of -height/2
     The left has an x value of -width/2
     We can get the x position by using pos.x
     And the y position by pos.y
  */
  void bounce() {
    // ADD BOUNCING OFF THE WALLS CODE HERE
  }
  
  void turns(float angle) {
    theta += angle;
  }
  
  /**
   * calculate the coordinates of the shape
   */
  void updatePoints() {
    // nose
    pt[0] = new PVector(pos.x+siz*cos(theta), pos.y+siz*sin(theta));
    // bottom left
    pt[1] = new PVector(pos.x+1.7*siz*cos(theta+(PI+0.7)), pos.y+1.7*siz*sin(theta+(PI+0.7)));
    // bottom right
    pt[2] = new PVector(pos.x+1.7*siz*cos(theta+(PI-0.7)), pos.y+1.7*siz*sin(theta+(PI-0.7)));
  }  
  
  /**
   * Draw the thruster triangles
   */  
  void drawThruster() {
    tr[0] = PVector.lerp(pt[1], pt[2], 0.25);            // sides of flame 0.25 and 0.75 between the base of the ship
    tr[1] = PVector.lerp(pt[1], pt[2], 0.75);
    PVector middle = PVector.lerp(pt[1], pt[2], 0.5);    // middle of the base
    tr[2] = PVector.lerp(middle, pt[0], -1.5);           // point of the red flame
    tr[3] = PVector.lerp(middle, pt[0], -0.5);           // point of the orange flame
    noStroke(); 
    fill(255,0,0);
    triangle(tr[0].x, tr[0].y, tr[1].x, tr[1].y, tr[2].x, tr[2].y);
    fill(255,102,0);
    triangle(tr[0].x, tr[0].y, tr[1].x, tr[1].y, tr[3].x, tr[3].y);
  }
}