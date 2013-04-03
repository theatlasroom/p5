//create a simple bloom filter, using 2 stage shader processing
PGraphics src, blurhoriz, blurvert;
PShader glow;

float radius = 0.0;

void setup(){
  size(768, 480, P2D);
  
  glow = loadShader("glow.glsl");
  //set up the 3 buffers
  src = createGraphics(width, height, P2D);
  blurhoriz = createGraphics(width, height, P2D);
  blurvert = createGraphics(width, height, P2D);
}

void draw(){
  //set the blur radius
  radius += random(-1, 1);
  glow.set("radius", radius);
  
  src.beginDraw();
  src.background(0);
  src.fill(255);
  src.ellipse(width/2, height/2, 100, 100);
  src.endDraw();
  
  //blur shader horizontal
  glow.set("dir", 1.0, 0.0);
  blurhoriz.beginDraw();
  blurhoriz.shader(glow);
  blurhoriz.image(src,0,0);
  blurhoriz.endDraw();
  
  //blur shader vertical
  glow.set("dir", 0.0, 1.0);
  blurvert.beginDraw();
  blurvert.shader(glow);
  blurvert.image(blurhoriz,0,0);
  blurvert.endDraw();
  //draw the final buffer to the screen
  image(blurvert, 0, 0);
}
