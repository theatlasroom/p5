#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

//define the typr of shader to he used
#define PROCESSING_LIGHT_SHADER

varying vec4 vertColor; //built in vertex colour, passed from vertex shader

void main() {
  // Outputting pixel color (interpolated across triangle)
  gl_FragColor = vertColor; 
}