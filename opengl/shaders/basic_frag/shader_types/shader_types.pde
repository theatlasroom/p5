PShape can;  //datatype for storing shapes
float angle;
PShader colshader, texshader;
int shader_type = 0, COL = 0, TEX=1;
PImage tex;

void setup(){
  //create canvas
  shader_type = TEX;  
  size(640, 360, P3D);
  if (shader_type == COL){
    can = createCan(100, 200, 32);
    colshader = loadShader("colorfrag.glsl", "colorvert.glsl");
  }
  else {
    CreateTex();    
    can = createCanTex(100, 200, 32);
    texshader = loadShader("texfrag.glsl", "texvert.glsl");    
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  rotateY(angle);
  if (shader_type == COL){
    shader(colshader);
  }  
  else {
    shader(texshader);
  }
  shape(can);  //draw the relevant shape onto the display 
  angle += 0.01;  
}

PShape createCan(float r, float h, int detail){
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);  //begin the shape using quad strips
  sh.fill(255, 255, 0);
  sh.noStroke();
  for (int i=0;i<=detail;i++){
    float angle = TWO_PI/detail;
    float x = sin(i*angle);
    float y = cos(i*angle);
    float z = float(i)/detail;
    sh.normal(x, 0, z);
    sh.vertex(x*r, -h/2, y*r, z, 0);
    sh.vertex(x*r, h/2, y*r, z, 1);   
  }
  sh.endShape();
  return sh;
}

void CreateTex(){
  //create texture to draw the texture data into, then pass the texture to the geometry
  //PGraphics tex;  //define the offscreen buffer to be used as the texture
  tex = createImage(width, height, ARGB);
  //flll the texture with colors
  tex.loadPixels();
  for (int i=0;i<tex.pixels.length;i++){
    //tex.pixels[i] = color(0, 90, 102, i % tex.width * 2);
    tex.pixels[i] = color(random(150,200), random(150,200), random(150,200), random(0,255));
  }
  tex.updatePixels();  
}


PShape createCanTex(float r, float h, int detail){
  //draw the shape
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);  //begin the shape using quad strips
  sh.noStroke();
  sh.texture(tex); //set the texture
  for (int i=0;i<=detail;i++){
    float angle = TWO_PI/detail;
    float x = sin(i*angle);
    float y = cos(i*angle);
    float z = float(i)/detail;
    sh.normal(x, 0, z);
    sh.vertex(x*r, -h/2, y*r, z, 0);
    sh.vertex(x*r, h/2, y*r, z, 1);   
  }
  sh.endShape();
  return sh;
}
