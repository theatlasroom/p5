//create a simple bloom filter, using 2 stage shader processing
PGraphics src, thresh_buffer, blurhoriz, blurvert;
PShader glow, threshold;

int num_circles = 1, max_circ_radius = 0;
float radius = 0, xoff = 0, yoff = 0;
float[] radii = new float[num_circles];

void setup(){
  size(768, 480, P2D);
  
  threshold = loadShader("threshold.glsl");
  glow = loadShader("glow.glsl");
  //set up the 3 buffers
  src = createGraphics(width, height, P2D);
  thresh_buffer = createGraphics(width, height, P2D);
  blurhoriz = createGraphics(width, height, P2D);
  blurvert = createGraphics(width, height, P2D);
  
  max_circ_radius = width/10;
  float step = max_circ_radius / num_circles;
  for (int i=0;i<num_circles;i++)
    radii[i] = max_circ_radius - (i*step);
}

void draw(){
  xoff += random(-3, 3);
  yoff += random(-3, 3);
  //set the blur radius
  //radius += random(-15, 15);
  radius = 4.0;
  glow.set("radius", radius);
  
  //draw raw geometry into first buffer
  src.beginDraw();  
  src.stroke(0, 255, 0, 255);  
  src.background(0);
  for (int i=0;i<num_circles;i++){
    src.fill(255, 255);
    src.ellipse(width/2, height/2-height/4, radii[i], radii[i]);
    src.ellipse(width/2-width/4, height/2+height/4, radii[i], radii[i]);
    src.ellipse(width/2+width/4, height/2+height/4, radii[i], radii[i]);
  }  
  src.endDraw();
  
  //threshold buffer
  thresh_buffer.beginDraw();
  thresh_buffer.image(src,0,0);  
  thresh_buffer.shader(threshold);
  thresh_buffer.endDraw();
  
  //blur shader horizontal
  glow.set("dir", 1.0, 0.0);
  blurhoriz.beginDraw();
  blurhoriz.image(thresh_buffer,0,0);  
  blurhoriz.shader(glow);
  blurhoriz.endDraw();
  
  //blur shader vertical
  glow.set("dir", 0.0, 1.0);
  blurvert.beginDraw();
  blurvert.shader(glow);  
  blurvert.image(blurhoriz,0,0);  
  blurvert.endDraw();
  
  //draw the blended buffer to the screen
  src.blend(blurvert, 0, 0, src.width, src.height, 0,0, blurvert.width, blurvert.height, BLEND);
  image(src, 0, 0);
}
