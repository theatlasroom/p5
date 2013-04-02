PShader frag;
int side_len = 100;
float angle = 0;

void setup(){
  size(720, 480, OPENGL); 
  frag = loadShader("frag.glsl");
  //apply the shader  
  shader(frag);
}

void draw() {
  translate(width/2, height/2-side_len/2); //translate to centre of screen    
  background(0);  //colour the background black
  //draw three vertices that will make up a triangle
  beginShape();
    fill(255,0,0);  //set the vertex colour to red
    vertex(0, 0);
    fill(0,255,0);  //set the vertex colour to green
    vertex(side_len, side_len);
    fill(0,0,255);  //set the vertex colour to blue
    vertex(-side_len, side_len);
  endShape();
}

