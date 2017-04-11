/*
 * afterRefactoringBall.pde
 *
 * Project: Creative coding using Processing - Workshop: An introduction to creative coding using Processing
 *
 * Supported Processing version: 3.2.3
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
  // check if the typed key was 'x' (ASCII code 120),
  // and if so, reverse the ball's moving state

  // check key
  if (key == 'x')
  { 
    // reverse the ball's movement state
    myBall.isMoving = !myBall.isMoving;
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
  int movementStep;
  
  // default class constructor
  Ball()
  {
    // initialize all class properties
    this.x = 300;
    this.y = 200;
    this.diameter = 25;
    this.isMoving = false;
    this.movementStep = 4;
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
    // draw an ellipse
    ellipse(this.x, this.y, this.diameter, this.diameter);
  }
};