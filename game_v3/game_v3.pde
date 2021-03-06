Player player= new Player();
boolean gameOver = false;
 
float[] landHeights = new float[0];
float landSegmentWidth = 5;
float currentHeight = 500;
 
import processing.serial.*;

Serial myPort;
 
void setup() {
  size(600, 400);
  
 // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[0], 115200);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
  
}
 
void draw() {
  background(0);
 
   
 
  if (gameOver) {
    text("GAME OVER", 200, 175);
    fill(255, 0, 0);
    textSize(32);
  }
  else {
    
    if(landHeights.length>0) {
      landHeights = subset(landHeights, 1); 
       
    }
    while(landHeights.length<width/landSegmentWidth) {
      landHeights = append(landHeights, currentHeight);
      currentHeight+=random(-6,6);
      if(currentHeight>height) {
        currentHeight = height;
      } else if(currentHeight<200) {
       currentHeight = 200;
      }
    }
     
    // control player with the mouse :
    //player.x = mouseX;
    player.yVel *=0.96;
    
    
    //------------------
    //stuff we are adding
    String inString = myPort.readStringUntil('\n');
    
   if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   // convert to an int and map to the screen height:
   float inByte = float(inString); 
   float inByte2 = map(inByte, 1800, 2150, -2, 2);
    // -----------------
    
    //if ((keyPressed) && (key==' ')) {
      
    player.yVel+= inByte2;

 
    player.y+=player.yVel;
 
    if (player.y>) {
      gameOver = true;
    }
    }
  } 
  
  player.draw();
  noStroke();
  for(int i = 0; i< landHeights.length; i++) {
    rect(i*landSegmentWidth, landHeights[i], landSegmentWidth, height);
    rect(i*landSegmentWidth, 0, landSegmentWidth, height-landHeights[i]);
     
  }
}
 
void mousePressed() {
  if(gameOver) {
   // reset
   // here's where you would add the code to reset the game
  }
   
   
}
 
class Player {
  float x;
  float y; 
  float yVel;
 
  Player() {
    x = 60;
    y = 150;
    yVel = 0;
  }
 
  void draw() {
    ellipse(x, y, 30, 20);
  }
}

