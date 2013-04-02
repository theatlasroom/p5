#define PROCESSING_TEXTURE_SHADER //define the shader as a texture shader
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;	//this is a pointer to the texture being used

varying vec4 vertColor;	//the color calculated at the vertex, passed in from the vertex shader
varying vec4 vertTexCoord;	//the texture coordinate calculated at the vertex, passed in from the vertex shader

void main() {
  gl_FragColor = texture2D(texture, vertTexCoord.st) * vertColor;	//apply the relevant part of the texture to the current fragment
  int si = int(vertTexCoord.s * 10.0);
  int sj = int(vertTexCoord.t * 10.0);
  gl_FragColor = texture2D(texture, vec2(float(si) / 10.0, float(sj) / 10.0)) * vertColor;
}