int gaugeValue = 0;
int gaugeValue2 = 0;

void setup() {
  // Serial2.begin(230400);
  Serial.begin(9600);
  pinMode(A0,INPUT);
  pinMode(A1,INPUT);
}

void loop() {
  gaugeValue = analogRead(A0);
  gaugeValue2 = analogRead(A1);
  Serial.print(millis());
  Serial.print(",");
  Serial.print(map(gaugeValue, 0, 1023, 0, 11000));  //RPM
  Serial.print(",");
  Serial.print("80");  //Engine Temperature
  Serial.print(",");
  Serial.print("4");  //Gear
  Serial.print(",");
  Serial.print(map(gaugeValue2, 0, 1023, 0, 150));  //Speed
  Serial.print(",");
  Serial.print(map(gaugeValue, 0, 1023, 0, 100));  //Brake Pressure
  Serial.print(",");
  Serial.print("12");  //Battery Voltage
  Serial.print(",");
  Serial.print("1");  //Radiator
  Serial.print(",");
  Serial.print("0");  //Data Logging
  Serial.print(",");  
  Serial.print(map(gaugeValue2, 0, 1023, 0, 100));  //Throttle
  Serial.print(",");
  Serial.print(map(gaugeValue2, 0, 1023, 0, 120));  //Brake Temperature
  Serial.print(",");
  Serial.print(map(gaugeValue, 0, 1023, 0, 150));  //Front Left
  Serial.print(",");
  Serial.print(map(gaugeValue2, 0, 1023, 0, 150));  //Front Right
  Serial.print(",");
  Serial.print(map(gaugeValue, 0, 1023, 0, 150));  //Rear Left
  Serial.print(",");
  Serial.print(map(gaugeValue2, 0, 1023, 0, 150));  //Rear Right
  Serial.print(",");
  Serial.print(gaugeValue);  //Accelerometer X Axis
  Serial.print(",");
  Serial.print(gaugeValue2);  //Accelerometer Y Axis
  Serial.print(",");
  Serial.println("30");  //Steering Angle
}
