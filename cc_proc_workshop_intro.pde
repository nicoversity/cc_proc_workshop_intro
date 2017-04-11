/*
 * cc_proc_workshop_intro.pde
 *
 * Project: Creative coding using Processing - Workshop: An introduction to creative coding using Processing
 *
 * Supported Processing version: 3.3
 *
 * Author: Nico Reski
 * Web: http://reski.nicoversity.com
 * Twitter: @nicoversity
 */
 
// declare object instances
Ball myBall;

void setup()
{
  size(1024, 768);  // setup our canvas to draw in
  frameRate(30);    // setup the frame rate in FPS (frames per second)
      
  // create (instantiate) object (instance) of Ball class
  myBall = new Ball();

  // trigger notification in console
  println("Processing setup!");
}
 
 
void draw()
{   
  // clear canvas
  // Note: IMPORTANT to do that manually! openFrameworks does it automatically for you!
  clear();
   
  // setup background intensity (R,G,B arguments are also valid)
  background(230);

  // if ball is supposed to move: update it's position
  if(myBall.isMoving)
  {
    // calculate new x coordinate of the ball
    int newXPos = myBall.x + myBall.movementStep;

    // move ball to new position
    myBall.moveTo(newXPos, myBall.y);

    // let the ball bounce between the application window's borders
    // if ball's x position (considering its radius) is outside right border OR left border
    if ( (myBall.x > width - myBall.diameter/2) || (myBall.x < 0 + myBall.diameter/2) )
    {
      myBall.movementStep *= -1;
      println("!!! BOUNCE !!!");
    }
  }

  // enable "fill"-flag and set color
  fill(255, 245, 0);

  // set figure outline via stroke
  stroke(236, 50, 135);
  //noStroke();

  // draw an ellipse
  myBall.draw();

  // draw application feedback
  drawApplicationFeedback();
}
 

void keyTyped()
{
  
  // check for typed key
  switch (key) {

    // reverse ball's moving state
    case 'x':
      myBall.isMoving = !myBall.isMoving;
      break;

    // increase ball's diameter
    case 'w':
      myBall.diameter += myBall.diameterStep;
      break;

    // decrease ball's diameter
    case 's':
      myBall.diameter -= myBall.diameterStep;
      break;

    // do nothing
    default:
      break;
  }
}


void mousePressed()
{
  // only toggle ball's following state if it is currently not moving
  if(!myBall.isMoving)
  {
    // calculate distance between mouse position and ball object
    float distance = dist(myBall.x, myBall.y, mouseX, mouseY);

    // if distance is less than the ball's radius (diameter/2): clicked inside the ball
    if(distance < myBall.diameter/2)
    {
      // toggle between mouse following state
      myBall.isFollowing = !myBall.isFollowing;

      // change ball's colors randomly
      myBall.ballColor.randomize();
      myBall.strokeColor.randomize();
    }
  }
}


void mouseMoved() 
{
  // move ball object to the current mouse position
  if(myBall.isFollowing)
  {
    myBall.moveTo(mouseX, mouseY);
  }
}

 
void drawApplicationFeedback()
{
  // setup text color, stroke and size
  fill(236, 50, 135);
  noStroke();
  textSize(14);

  // display text about current framerate at position x,y
  // Note: nf() is a utility function to format numbers ->
  // 3 digits to the left of the decimal point, 1 digit to the right of the decimal point
  text("FPS = " + nf(frameRate,3,1), 10, 18);

  // display current coordinates of the mouse
  text("Mouse x|y: " + mouseX + " | " + mouseY, 110, 18);

  // display last pressed key and its ASCII key code
  text(key + " = " + keyCode, 280, 18);
}

// ---
// Ball class
// ---
class Ball {
  
  // class properties
  int x;
  int y;
  int diameter;
  boolean isMoving;
  boolean isFollowing;
  int movementStep;
  int diameterStep;
  Color ballColor;
  Color strokeColor;
  
  // default class constructor
  Ball()
  {
    // initialize all class properties
    this.x = 300;
    this.y = 200;
    this.diameter = 25;
    this.isMoving = false;
    this.isFollowing = false;
    this.movementStep = 4;
    this.diameterStep = 5;
    this.ballColor = new Color();
    this.strokeColor = new Color();
  }
  
  // function to move the ball to the new coordinates
  void moveTo(int xDestiny, int yDestiny)
  {
    this.x = xDestiny;
    this.y = yDestiny;
  }
  
  // function to draw the ball
  void draw()
  {
    // start a new drawing (style) state
    pushStyle();

    // enable "fill"-flag and set color
    fill(this.ballColor.r, this.ballColor.g, this.ballColor.b);

    // set figure outline via stroke
    stroke(this.strokeColor.r, this.strokeColor.g, this.strokeColor.b);
    //noStroke();

    // draw an ellipse
    ellipse(this.x, this.y, this.diameter, this.diameter);

    // restore original drawing (style) state
    popStyle();
  }
};


// ---
// Simple RGB Color class
// ---
class Color {
  
  // class properties
  int r, g, b;
  
  // default class constructor
  Color()
  {
    // random color on instantition
    randomize();
  }
  
  // function to change the color according to a set of arguments
  void setColor(int red, int green, int blue) {
    this.r = red;
    this.g = green;
    this.b = blue;
  }

  // function to change the color randomly
  void randomize() {
    this.r = (int)random(255);
    this.g = (int)random(255);
    this.b = (int)random(255);
  }
};