import processing.serial.*;
PImage img;

Serial myPort;
int[] values = new int[18];
int[] rpm = new int[385];
int[] speed = new int[385];
int[] brakePress = new int[385];
int[] throttle = new int[385];
int[] brakeTemp = new int[385];
int[] xAccel = new int[240];
int[] yAccel= new int[240];
int[] xAccel1 = new int[240];
int[] yAccel1= new int[240];

void setup() {
  img=loadImage("logoW.png");
  size(1920, 1080);
  smooth();
  myPort = new Serial(this, Serial.list()[0], 9600);
  for (int i = 0; i < rpm.length; i++) {
    rpm[i] = 0;
    speed[i] = 0;
    brakePress[i] = 0;
    throttle[i] = 0;
    brakeTemp[i] = 0;
  }
  for (int i = 0; i < xAccel.length; i++) {
    xAccel[i] = 0;
    yAccel[i] = 0;
    xAccel1[i] = 0;
    yAccel1[i] = 0;
  }
}

void draw() {
  background(30);
  image(img, 710, 490, 540, 200);
  if (myPort.available() > 0) {
    String input = myPort.readStringUntil('\n');
    println(input);
    if (input != null) {
      String[] valuesStr = split(input.trim(), ",");
      if (valuesStr.length==18) {
        for (int i = 0; i < values.length; i++) {
          values[i] = int(valuesStr[i]);
        }
      }
    }
  }
  int randValue = values[1];
  int randValue1 = values[4];
  int randValue2 = values[5];
  int randValue3 = values[9];
  int randValue4 = values[10];
  int randValue5 = values[15];
  int randValue6 = values[16];
  for (int i = 0; i < rpm.length-1; i++) {
    rpm[i] = rpm[i+1];
    speed[i] = speed[i+1];
    brakePress[i] = brakePress[i+1];
    throttle[i] = throttle[i+1];
    brakeTemp[i] = brakeTemp[i+1];
  }
  rpm[rpm.length-1] = randValue;
  speed[speed.length-1] = randValue1;
  brakePress[brakePress.length-1] = randValue2;
  throttle[throttle.length-1] = randValue3;
  brakeTemp[brakeTemp.length-1] = randValue4;
  for (int i = 0; i < xAccel.length-1; i++) {
    xAccel[i] = xAccel[i+1];
    yAccel[i] = yAccel[i+1];
    xAccel1[i] = xAccel1[i+1];
    yAccel1[i] = yAccel1[i+1];
  }
  xAccel[xAccel.length-1] = randValue5;
  yAccel[yAccel.length-1] = randValue6;
  xAccel1[xAccel1.length-1] = int(map(randValue5,0,1023,-3,3));
  yAccel1[yAccel1.length-1] = int(map(randValue6,0,1023,-3,3));
  drawGauge(width-170, height-90, values[1], "RPM", 11000);
  texts(200, 930, "Engine Temp", values[2], " °C");
  texts(60, 930, "Gear", values[3], "");
  drawGauge(width-475, height-90, values[4], "Speed", 150);
  drawBar(750, 970, values[5], "Brake", 100);
  texts(380, 930, "Battery Volt", values[6], " V");
  onnoff(100, 710, "R", values[7]);
  onnoff(100, 810, "D", values[8]);
  drawBar(850, 970, values[9], "Throttle", 100);
  drawBar(940, 970, values[11], "FL", 150);
  drawBar(1030, 970, values[12], "FR", 150);
  drawBar(1120, 970, values[13], "RL", 150);
  drawBar(1210, 970, values[14], "RR", 150);
  circularGraph(300, 760, values[15], values[16]);
  texts(570, 930, "Steering Angle", values[17], " °");
  drawGraph(385, 125, speed, "Speed", 60, 25, 150, 255, 165, 0, 8, 0);
  drawGraph(385, 125, rpm, "RPM", 1000, 25, 11000, 255, 165, 0, 8, 0);
  drawGraph(385, 125, throttle, "Throttle", 60, 210, 100, 255, 165, 0, 8, 0);
  drawGraph(385, 125, brakePress, "Brake", 1000, 210, 100, 255, 165, 0, 8, 0);
  drawGraph(385, 125, brakeTemp, "Brake", 1000, 210, 120, 220, 0, 0, 8, 0);
  drawGraph(240, 100, xAccel1, "", 60, 400, 3, 255, 165, 0, 5, 1);
  drawGraph(240, 100, yAccel1, "", 60, 400, 3, 220, 0, 0, 5, 1);
  lap();
  textSize(15);
  strokeWeight(10);
  stroke(255,165,0);
  point(1825,312);
  stroke(220,0,0);
  point(1825,332);
  text("Press",1850,310);
  text("Temp",1850,330);
  textSize(17);
  strokeWeight(12);
  stroke(255,165,0);
  point(595,532);
  stroke(220,0,0);
  point(595,557);
  text("X",610,530);
  text("Y",610,555);
  textSize(40);
  text("Raw Data", 1600, 410);
  textSize(22);
  text("On Time", 1400, 470);
  text(values[0], 1525, 470);
  text("RPM", 1725, 470);
  text(values[1], 1825, 470);
  text("Engine Temp", 1400, 510);
  text(values[2], 1525, 510);
  text("Gear", 1725, 510);
  text(values[3], 1825, 510);
  text("Speed", 1400, 550);
  text(values[4], 1525, 550);
  text("Brake Pressure", 1725, 550);
  text(values[5], 1825, 550);
  text("Battery Voltage", 1400, 590);
  text(values[6], 1525, 590);
  text("Radiator", 1725, 590);
  text(values[7], 1825, 590);
  text("Data Logging", 1400, 630);
  text(values[8], 1525, 630);
  text("Throttle", 1725, 630);
  text(values[9], 1825, 630);
  text("Brake Temp", 1400, 670);
  text(values[10], 1525, 670);
  text("Front Left", 1725, 670);
  text(values[11], 1825, 670);
  text("Front Right", 1400, 710);
  text(values[12], 1525, 710);
  text("Rear Left", 1725, 710);
  text(values[13], 1825, 710);
  text("Rear Right", 1400, 750);
  text(values[14], 1525, 750);
  text("Accelerometer X", 1725, 750);
  text(values[15], 1825, 750);
  text("Accelerometer Y", 1400, 790);
  text(values[16], 1525, 790);
  text("Steering Angle", 1725, 790);
  text(values[17], 1825, 790);
}

void drawGauge(int x, int y, int value, String label, int maxValue) {
  pushMatrix();
  translate(x, y);
  noFill();
  strokeWeight(40);
  stroke(255, 165, 0);
  arc(0, 0, 225, 225, -PI, map(value, 0, maxValue, -PI, 0));
  textAlign(CENTER, CENTER);
  textSize(30);
  text(value, 0, -40);
  text(label, 0, 0);
  popMatrix();
}

void circularGraph(int x, int y, int xVal, int yVal) {
  pushMatrix();
  translate(x, y);
  strokeWeight(3);
  stroke(255);
  noFill();
  ellipse(0, 0, 225, 225);
  ellipse(0, 0, 150, 150);
  ellipse(0, 0, 75, 75);
  line(0, -120, 0, 120);
  line(-120, 0, 120, 0);
  strokeWeight(25);
  stroke(255, 165, 0);
  point(map(xVal, 0, 1023, -112, 112), map(yVal, 0, 1023, -112, 112));
  popMatrix();
}

void drawBar(int x, int y, int value, String label, int maxValue) {
  pushMatrix();
  translate(x, y);
  float barHeight = map(value, 0, maxValue, 0, 130);
  noStroke();
  fill(255, 165, 0);
  rect(0 - 20, -barHeight, 40, barHeight);
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text(value, 0, -barHeight-30);
  text(label, 0, 20);
  popMatrix();
}

void drawGraph(float w, float h, int[] data, String label, int xOffset, int yOffset, int maxValue, int str1, int str2, int str3, int time, int flag) {
  pushMatrix();
  translate(xOffset, yOffset);
  int i=0, x1=0, x2 = 0, y1=0, y2 = 0;
  int pointInterval = int(w / data.length)*2;
  strokeWeight(3);
  stroke(str1, str2, str3);
  for (i = 1; i < data.length; i++) {
    x1 = (i-1) * pointInterval;
    y1 = int(h - (data[i-1] * h / maxValue));
    x2 = i * pointInterval;
    y2 = int(h - (data[i] * h / maxValue));
    line(x1, y1, x2, y2);
  }
  textSize(20);
  text(data[i-1], x2 + 20, y2 - 5);
  textSize(25);
  text(label, x2+80, 70);
  stroke(70);
  line(0, 0, x2, 0);
  line(0, h, x2, h);
  textSize(20);
  for (i = 0; i <= time; i++) {
    line(int((96.25 * i)), -10, int((96.25 * i)), h + 10);
    text(i - time, int((96.25 * i)), h + 20);
  }
  if (flag==1) {
    line(0, 2*h, x2, 2*h);
    for (i = 0; i <= time; i++) {
      line(int((96.25 * i)), h-10, int((96.25 * i)), 2*h + 10);
    }
    textSize(25);
    text("G's", x2 + 65, 95);
    flag=0;
  }
  popMatrix();
}

void texts(int x, int y, String label, int value, String unit) {
  pushMatrix();
  translate(x, y);
  textAlign(CENTER, CENTER);
  textSize(60);
  text(value+unit, 0, 0);
  textSize(30);
  text(label, 0, 60);
  popMatrix();
}

void onnoff(int x, int y, String label, int value) {
  pushMatrix();
  translate(x, y);
  textAlign(CENTER, CENTER);
  strokeWeight(80);
  if (value==1)
    stroke(0, 150, 0);
  else
    stroke(200, 0, 0);
  point(0, 0);
  text(label, 0, -5);
  popMatrix();
}

void lap() {
  textAlign(CENTER, CENTER);
  strokeWeight(2);
  stroke(255);
  noFill();
  textSize(35);
  text("Lap Time : ", 550, 720);
  text("01:45:376", 545, 770);
}
