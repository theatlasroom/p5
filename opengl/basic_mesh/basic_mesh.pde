//construct a basic mesh based on randomly generated points
//start with constructing a triangle, then expand from there

int bg = 255, col = 0;
PVector[] pt;
int side_length = (int)50/2;

void setup(){
  //create the new vector array
  pt = new PVector[3];
  size(768, 480, OPENGL);
  background(bg);
  stroke(col, 75);  //75% transparent
  noFill();
  pt[0] = new PVector(0,0,0);
  pt[1] = new PVector(-side_length,side_length, 0);
  pt[2] = new PVector(side_length,side_length,0);
}

void draw(){
 background(bg);  //clear the screen
 translate(width/2, height/2);  //translate to the centre
 lights();  //setup the lights
 Face(pt);  //draw a new face
}

void Face(PVector pt[]){
  //take 3 points 
  //draw a transparent sphere at each point
  //draw a line to join vertices
  beginShape();  
  for (int i=0;i<3;i++){
    vertex(pt[i].x,pt[i].y,pt[i].z);  //draw the 3 vertices of the face
    pushMatrix();
    translate(pt[i].x,pt[i].y,pt[i].z);  //draw each vertex of the face
    sphere(10);   //mark each vertex with a sphere
    popMatrix();    
  }
  endShape();  
}
