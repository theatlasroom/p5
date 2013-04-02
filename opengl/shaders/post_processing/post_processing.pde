/*import processing.video.*;
Movie clip;
float xpt = 0, ypt=0;*/
PShader edges,channel_offset;
PImage obj;

int scale = 7; //factor to scale the image by
int offs = 10;

void setup(){
  frameRate(24);
  background(0);
  obj = loadImage("cup.jpg");  
  size(obj.width/scale, obj.height/scale, P2D);
  obj.resize(obj.width/scale, obj.height/scale);
  //edges = loadShader("edge-detect.frag.glsl");
  //load the channel offset fragment shader
  channel_offset = loadShader("offs.glsl");
}

void draw(){
  channel_offset.set("roff", random(-offs, offs));
  channel_offset.set("goff", random(-offs, offs));
  channel_offset.set("boff", random(-offs, offs));
  shader(channel_offset);  
  image(obj, 0, 0, width, height); //send textured quad to the GPU (image makes use of beginshape(QUADS)/endshape
}

/*void movieEvent(Movie m) {
  m.read();  //read the next frame
}*/
