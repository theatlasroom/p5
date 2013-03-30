//construct a basic mesh based on randomly generated points
//start with constructing a triangle, then expand from there

int bg = 255, col = 0;
PVector[] pt;
int side_length = 50;
float angle = 0;

void setup(){
  //create the new vector array
  pt = new PVector[4];
  size(768, 480, OPENGL);
  background(bg);
  stroke(col, 75);  //75% transparent
  noFill();
  pt[0] = new PVector(0,0,0);
  pt[1] = new PVector(-side_length,side_length, 0);
  pt[2] = new PVector(side_length,side_length,0);
  //pt[3] = new PVector(side_length,side_length,side_length);  
}

void draw(){
 translate(width/2, height/2);  //translate to the centre
 NextFrame();
}

void Render(){  //render the scene
 Face(pt);  //draw a new face   
}

void NextFrame(){  //perform the basic operations to update each frame
 background(bg);  //clear the screen 
 lights();  //setup the lights  
 //perform some simple rotations
 rotateX(angle);
 rotateY(angle); 
 angle+=PI/180;  //update the angle
 Render();  //render the scene
}

void Face(PVector pt[]){
  int next = 0;
  //take 3 points 
  //draw a transparent sphere at each point
  //draw a line to join vertices
  beginShape();  
  for (int i=0;i<3;i++){
    vertex(pt[i].x,pt[i].y,pt[i].z);  //draw the 3 vertices of the face
    pushMatrix();
    translate(pt[i].x,pt[i].y,pt[i].z);  //draw each vertex of the face
    next = i+1;
    next = (i < 3) ? next : i;            //make sure the next vertex exists, otherwise loop back to first
    println("i: " + i + " next: " + next);
    Edge(pt[i], pt[next]);               //draw each edge between vertices
    sphere(5);   //mark each vertex with a sphere                  
    popMatrix();    
  }
  endShape();  
}

void Edge(PVector pt1, PVector pt2){line(pt1.x, pt1.y, pt1.z, pt2.x, pt2.y, pt2.z); } //render the line
