//construct a basic mesh based on randomly generated points
//start with constructing a triangle, then expand from there

int bg = 255, col = 0;
PVector[] pt;
int side_length = 50;
float angle = 0, opacity = 100;

void setup(){
  //create the new vector array
  pt = new PVector[4];
  size(768, 480, OPENGL);
  background(bg);
  stroke(col, opacity);  //set the alpha transparency
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
  int next = 0, num_vertices = 3;
  //take 3 points 
  //draw a transparent sphere at each point
  //draw a line to join vertices
  beginShape();    
  for (int i=0;i<num_vertices;i++){
    vertex(pt[i].x,pt[i].y,pt[i].z);  //draw the 3 vertices of the face
    pushMatrix();
    next = (next < num_vertices-1) ? next+1 : 0;            //make sure the next vertex exists, otherwise loop back to first
    stroke(col);  //fully opaque    
    Edge(pt[i], pt[next]);               //draw each edge between vertices
    stroke(col, opacity);  //set the stroke and the specified opacity    
    translate(pt[i].x,pt[i].y,pt[i].z);  //draw each vertex of the face        
    sphere(2);   //mark each vertex with a sphere                  
    popMatrix();   
  }
  vertex(pt[0].x,pt[0].y,pt[0].z);  //connect the final vertex  
  endShape();  //close off the shape, render it
}

void Edge(PVector pt1, PVector pt2){line(pt1.x, pt1.y, pt1.z, pt2.x, pt2.y, pt2.z); } //render the line
