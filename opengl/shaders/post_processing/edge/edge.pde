import processing.video.*;
Movie clip;
float xpt = 0, ypt=0;

PShader edges;

void setup(){
  size(640, 480, OPENGL);
  background(0);
  edges = loadShader("edge-detect.glsl");
  shader(edges);
  clip = new Movie(this, "lydia.mov");
  //clip.play();
}

void draw(){
  translate(width/2, height/2);
  background(0);
  //edges.set("mousex", random(0.5,1), 0, random(0.5, 1), 1.0);
  shader(edges);
  //fill(255);
  ellipse(xpt, ypt, 50, 50);
  xpt += random(-1, 1);
  ypt += random(-1, 1);  
  //image(clip, 0, 0, width, height); //send textured quad to the GPU (image makes use of beginshape(QUADS)/endshape
}

void movieEvent(Movie m) {
  m.read();  //read the next frame
}
