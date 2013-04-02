#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

varying vec4 vertColor;

void main() {
  // Outputting pixel color (interpolated across triangle)
  gl_FragColor = vertColor; 
}