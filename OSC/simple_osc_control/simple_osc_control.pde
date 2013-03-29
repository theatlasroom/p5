import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

/*This sketch is simply to figure out how to send osc messages from a touchosc device*/
float x_speed = 1, y_speed = 1;
float x_angle = 0, y_angle = 0;

void setup(){
  size(720, 480, P3D);  
  initialize();
}

void initialize(){
  background(0);
  stroke(255);
  noFill(); 
  /* start oscP5, listening for incoming messages at port 8000 */
  oscP5 = new OscP5(this,5000);  
}

void draw(){  
  pushMatrix();  
  PerformTransformations();    
  box(100);
  popMatrix(); 
  /*if (frameCount % 25 == 0){
     x_speed = (int)(random(0.1, 1) * 360);
     y_speed = (int)(random(0.1, 1) * 360);
  }*/
}

void PerformTransformations(){  
  fill(0,20);
  rect(0,0,width,height);
  noFill();   
  translate(width/2, height/2);
  x_angle += (x_speed > 0) ? PI/x_speed : 0;
  y_angle += (y_speed > 0) ? PI/y_speed : 0;  
  rotateX(x_angle);
  rotateY(y_angle);  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  
  String addr = theOscMessage.addrPattern();    
  if(addr.equals("/1/xy1")){
    println("x: " + theOscMessage.get(0).floatValue());
    println("y: " + theOscMessage.get(1).floatValue());
    float x = theOscMessage.get(0).floatValue();
    float y = theOscMessage.get(1).floatValue();
    
    x = map(x,0,1,1,360);
    y = map(y,0,1,1,360);
    
    x_speed = x/360;
    y_speed = y/360;    
  }
  else {
    /* print the address pattern and the typetag of the received OscMessage */
    print("### received an osc message.");
    println(" addrpattern: "+theOscMessage);
    print(" addrpattern: "+theOscMessage.addrPattern());
    println(" typetag: "+theOscMessage.typetag());    
  }    
}
