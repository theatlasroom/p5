#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;	//the modelview projection matrix
uniform mat4 texMatrix;	//this rescales the texture coordinates for each vertex

attribute vec4 vertex;	//the current vertex position
attribute vec4 color;	//the current vertex color
attribute vec2 texCoord;	//texture coordinates at this vertex

varying vec4 vertColor;	//variable to be passed to the fragment shader, containing the color at this vertex
varying vec4 vertTexCoord;

void main() {
  gl_Position = transform * vertex;
    
  vertColor = color;
  vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
}
