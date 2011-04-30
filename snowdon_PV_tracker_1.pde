// Hill climbing style tracker
// This does not scan a range, but constantly tries to obtain best output.. 

// known problems so far:
// unstable readings from arduino as servo is driven.. thus voltage tracking 
// seemed more stable.. current values were fluctuating too much.. 
// Servo will overshoot, if angle increments are large
// servo will jitter if super capacitors are not used.. 
// voltage for servo mustn't be too high or too low.. 


#include <Servo.h> 


Servo EWservo;
double mW;
double mWPrev=0;
double mWNow;
double difference;
int angle=90;

double VPrev = 0; //previous voltage.. 
double VNow;
void setup()
{

  Serial.begin(9600);
  
  EWservo.attach(4);          // Attach the East-West tracking servo to digital 4
  EWservo.write(90);           // set servo to mid-point
  
  
}


void loop()
{
  
  //EWservo.write(180);
  
  //delay(2000);
  
  //EWservo.write(0);
  
  //delay(2000);
  
  
  //mWNow =  get_mW();       // not used now, as unstable mW values at present.. 
  
  //difference = mWNow -mWPrev;   // on power
  VNow = analogRead(0);
  difference = VNow - VPrev;
  
  
  if(difference >= 0)
  {
    angle = angle + 5;
    EWservo.write(angle);
    delay(500);
    //mWPrev = mWNow;
    VPrev = VNow;
    //Serial.println("positive");
    
  }
  else
  {
    angle = angle - 5;
    EWservo.write(angle);
    delay(500);
    //mWPrev = mWNow;
    VPrev = VNow;
    //Serial.println("neg");
    
  }
  
}


  double get_mW() {
   
  double Volts =0 ;
  double Amps = 0;
  double controlVolts = 0;
  double Rload;
  
  for (int i=0; i<10; i++) {                         // Average the voltage over 10 readings every 50mS
   double analogValue = analogRead(0);
   Volts = Volts +  ((analogValue *4.95)/1023);
   
   double AnValue = analogRead(3);
   controlVolts = controlVolts +  ((AnValue * 4.95)/1023);
   double currentValue = analogRead(1);
   
   Amps = Amps +  ((currentValue * 4.95)/1023);
   
   
   
   
//   delay(2);
  }
  
  Amps = Amps*100;
  Serial.print(Volts);
  //Serial.print(" ");
  //Serial.print(Amps);
  //Serial.print(" ");
  //Serial.println(Volts*Amps);
  Serial.println("here");
  
  }









