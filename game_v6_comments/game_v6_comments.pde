/*initialize game factors like
a game player and variables used to
compute later in code
*/

Player player= new Player();
boolean gameOver = false;
 
float[] landHeights = new float[0];
float landSegmentWidth = 5;
float currentHeight = 350;

 // import serial library
import processing.serial.*;

Serial myPort;
 
void setup() {
  //set the GUI size
  size(600, 400);
  
 // List all the available serial ports
 println(Serial.list());
 // Open the available serial port
 myPort = new Serial(this, Serial.list()[0], 115200);
 // don't update unless there is an 'enter' key between
 //each data input (so it can read it each number as 1
 // data point)
 myPort.bufferUntil('\n');
  
}
 // draw function
void draw() {
  //set background = black
  background(0);
 
 //check that the game is still in play
  if (gameOver) {
    //if it is game over then display that in red
    text("GAME OVER", 200, 175);
    fill(255, 0, 0);
    textSize(32);
  }
  else {
    //if the game is not game over
    //it must be in play
    // so create the rectangles that make
    // the edges of the game
    if(landHeights.length>0) {
      landHeights = subset(landHeights, 1); 
       
    }
    
    //create random sizes for the rectangles (-6 to 6 in size
    //difference per box)
    // if the box is going to fill more than half screen size
    // make sure to cut off the box at the center
    // since the boxes on the top are the boxes mirrored from
    //the bottom, we don't want the top or bottom boxes 
    //ever going past half the screen
    while(landHeights.length<width/landSegmentWidth) {
      landHeights = append(landHeights, currentHeight);
      currentHeight+=random(-6,6);
      if(currentHeight>height) {
        currentHeight = height;
      } else if(currentHeight<200) {
       currentHeight = 200;
      }
    }
     
    // set the player's yvelocity
    player.yVel *=0.96;
    
    
    //------------------
    //read the incoming serial port data from the
    //arduino code to be used as input control
    //for the game
    String inString = myPort.readStringUntil('\n');
    
   if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   // convert to an int and map to the screen height:
   float inByte = float(inString); 
   float inByte2 = map(inByte, 1800, 2150, -2, 2);
    // -----------------
    
{
    // set the yvel based on the input
    // therefore the veolicty increases and decreases
    //depending on the distance your hand is from the
    // sensor pad  
    player.yVel+= inByte2;

    //add this velocity to the player position
    // to change where the oval gamepiece is
    player.y+=player.yVel;
    

    }
  } 
  
  //draw the oval at the current x and y
  //(more down below) iin player class
  player.draw();
  noStroke();
  //draw the rectangles on the top and bottom
  //as the screen refreshes, so do new random rectangles
  for(int i = 0; i< landHeights.length; i++) {
    rect(i*landSegmentWidth, landHeights[i], landSegmentWidth, height);
    rect(i*landSegmentWidth, 0, landSegmentWidth, height-landHeights[i]);
    
    //set the death parameters of the game
    //both parameters (top + bottom) have a tolerance of
    //25 pixels for game smoothness and to account for
    //size of oval gamepice
    
    //this one is for if the oval gamepiece hits the bottom
    //rectangles, the game is over   
    if (player.y<height-landHeights[i]-25) {
      gameOver = true;
    }
    //this one is for if the oval gamepiece hits the top
    //rectangles, the game is over       
    if (player.y>landHeights[i]+25) {
      gameOver = true;
    }
  }
}
 
void mousePressed() {
  if(gameOver) {
    //future code to restart the game could be added here
  }
   
   
}

//define the oval gamepiece
class Player {
  float x;
  float y; 
  float yVel;
 
 //starting position and velocity of gamepiece
  Player() {
    x = 60;
    y = 150;
    yVel = 0;
  }
 //size of oval gamepiece at its starting x and y
  void draw() {
    ellipse(x, y, 30, 20);
  }
}

