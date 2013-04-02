//per pixel lighting calculations
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

//define the typr of shader to he used
#define PROCESSING_TEXLIGHT_SHADER

uniform sampler2D texture;

varying vec4 vertColor; //built in vertex colour, passed from vertex shader
varying vec4 vertTexCoord;	//vertex texture coordinates

void main() {
  	// Outputting pixel color (interpolated across triangle)
  	gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor; 
}