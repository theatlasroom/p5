//define this as a color shader 
#define PROCESSING_COLOR_SHADER	

//define the required attr and uniforms
uniform mat4 transform;
attribute vec4 vertex;	//position of the current vertex
attribute vec4 color;	//color of the current vertex
varying vec4 vertColor;

//main function
void main(){	
	gl_Position = transform * vertex; //perform the modelview transformation to generate the vertex location
	vertColor = color;	//pass the colour at this vertex on to the fragment shader
}