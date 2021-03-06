//Initialize variables / define constants for code

#define resolution 8
#define mains 60 // for clock timing (60 Hz from mains voltage)

#define refresh 2 * 1000000 / mains //defines refresh rate based on input frequency (mains of 60 hz)

void setup() {
  
  //begin serial communication at 115,200 bps (bits per second) - 115,200 is highest default value of arduino
  Serial.begin(115200);

  // to reduce noise, all inputs are set to LOW
  // then we initialize the desired inputs
  for(int i = 2; i < 14; i++) {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }
  
  // next, set digital 8 as the input pin for digital readings
  pinMode(8, INPUT);
  pinMode(13, OUTPUT);
  
  //initialize a timer through the timer function below
  startTimer();
}

void loop() {  
  //print out the time (see subfunction bellow)
  //also converts from the binary time value to a DEC value
  //input of time is (pin8) and mask B00000001 which correlates to PORTB's digital pin 8
  int timeDec=time(8, B00000001);
  Serial.print(time(8, B00000001));
  Serial.print(" ");
  
  //thresholding
  
  if (timeDec>=1300)
  {
    analogWrite(A1,0);
    analogWrite(A3,0);
    analogWrite(A5,1024);
  }
  if (timeDec>=1500)
  {
    analogWrite(A1,0);
    analogWrite(A3,1024);
    analogWrite(A5,0);
  }
  if (timeDec>=1700)
  {
    analogWrite(A1,1024);
    analogWrite(A3,1024);
    analogWrite(A5,0);
  }
    if (timeDec>=2100)
  {
    analogWrite(A1,1024);
    analogWrite(A3,0);
    analogWrite(A5,0);
  }

} 

//calculating the time 
long time(int pin, byte mask) {
  //define the count to be 0 for each timing secetion, as well as the total time itself
  //reinitialize these as they are each distinct quantities of time between each refresh period
  unsigned long count = 0, total = 0;
  
  //while the user-created timer is less than the desired refresh rate, we can calculate the highs/lows of the digital pin
  while(checkTimer() < refresh) {
    //switch the pin to output so we can change PORTB to 0
    pinMode(pin, OUTPUT);
    //PORTB is the data register for digital pins 8-13
    //setting PORTB to zero sets the output for digital pin to LOW
    //this is necessary so that we can make sure we check the time between settings, thus we must start at LOW
    PORTB = 0;
    //now pin8 needs to be set back as an input to detect incoming data from the circuit
    pinMode(pin, INPUT);
    //PINB is the digital 0 or 1 values for the digital pins 8-13
    //it will become high when an input is detected
    //counts the time that it takes to charge the plates
    //this is done by counting how long the mask (mask will determine which pin to look at)
    //and how long PINB are LOW
    //once one of these becomes HIGH the plates are done charging, thus end the count
    while((PINB & mask) == 0)
      count++;
    //we also need to calculate the total time so we can relate the refresh rate (known quantity)
    //to the count time by comparing it to the total time
    total++;
  }
  
  //restart the timer since we are now outside the refresh rate
  startTimer();
  
  //scaling count from a small range to the total resolution (8 bits), then normalizing to the entire time period charged and uncharged
  //this gives us the normalized time that the plate spent charging
  return (count << resolution) / total;
}

//define the timer count as variable "timer0_overflow_count"
//volatile tagline is needed because we want the variable to be stored in the RAM
//the extern keyword allows the counter to be defined in another "external" context (other subfunctions)
extern volatile unsigned long timer0_overflow_count;

//simply initializes a counter to be used in the code
//more explanation in checkTimer()
void startTimer() {
  timer0_overflow_count = 0;
  TCNT0 = 0;
}

//a function to allow for checking how long the counter has been going for
unsigned long checkTimer() {
  return ((timer0_overflow_count << 8) + TCNT0) << 2;
  //timer0_overflow_count is the timer itself bit-shifted by the resolution
  //TCNT0 is the number of times the timer has overflowed * 256 (1 byte) 
  //converts back from 8 bits (1 byte) to 2 bits
  // converting to a lower number of bits (1) reduces how much time the counter counts for
  // but then increases the speed of sensor readings
}


