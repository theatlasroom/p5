PShape can;  //datatype for storing shapes
float angle;
PShader colshader, texshader, lightshader, texlightshader;
int shader_type = 0, COL = 0, TEX=1, LIT=2, TEX_LIT = 3;
PImage tex;
boolean HAS_LIGHTS = false;

void setup(){
  //create canvas
  shader_type = TEX_LIT;  
  size(640, 360, P3D);
  if (shader_type == TEX_LIT){
    boolean PER_PIXEL = true;
    CreateTex();            
    can = createCanTex(100, 200, 32);
    if (PER_PIXEL)
      texlightshader = loadShader("texlightfrag-pixel.glsl", "texlightvert-pixel.glsl");
    else
      texlightshader = loadShader("texlightfrag-vtx.glsl", "texlightvert-vtx.glsl");
    HAS_LIGHTS = true;
  } 
  else if (shader_type == LIT){
    boolean PER_PIXEL = true;
    can = createCan(100, 200, 32);
    if (PER_PIXEL)
      lightshader = loadShader("lightfrag-pixel.glsl", "lightvert-pixel.glsl");
    else
      lightshader = loadShader("lightfrag-vtx.glsl", "lightvert-vtx.glsl");
    HAS_LIGHTS = true;
  }
  else if (shader_type == TEX){
    CreateTex();    
    can = createCanTex(100, 200, 32);
    texshader = loadShader("texfrag.glsl", "texvert.glsl");    
  }
  else {
    can = createCan(100, 200, 32);
    colshader = loadShader("colorfrag.glsl", "colorvert.glsl");    
  }
}

void draw(){
  if (HAS_LIGHTS){    
    lights();
    pointLight(255, 255, 255, width/2, height, 200);
  }  
  background(0);
  translate(width/2, height/2);
  rotateY(angle);
  if (shader_type == TEX_LIT)
    shader(texlightshader);
  else if (shader_type == LIT)
    shader(lightshader);    
  else if (shader_type == TEX)
    shader(texshader);
  else 
    shader(colshader);
  shape(can);  //draw the relevant shape onto the display 
  angle += 0.01;  
}

PShape createCan(float r, float h, int detail){
  //textureMode(NORMAL);
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
