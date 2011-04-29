#include <Servo.h> 


Servo EWservo;
double mW;
double mWPrev=0;
double mWNow;
int angle=90;

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
  
  
  mWNow =  get_mW(); 
  
  
  
  if (mWNow > mWPrev)
  {
    
    angle = angle+10;
    EWservo.write(angle);
    
    mWPrev = mWNow;          // set previous value to 'now'
    mWNow = get_mW();        // get new mW value
    
     delay(20000);
     
     if(mWNow > mWPrev)    // keep increasing angle, else down.
     {
       angle = angle+10;
       EWservo.write(angle);
       mWPrev = mWNow; 
       
     }
     else{
       angle = angle-10;
       EWservo.write(angle);
       mWPrev = mWNow; 
     }
         
  }
    
  
    
  
  Serial.println(mW);
  
  //delay(1000);
  
  
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
  
  }









