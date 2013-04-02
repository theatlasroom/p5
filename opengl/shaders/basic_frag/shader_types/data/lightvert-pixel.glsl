	
#define PROCESSING_LIGHT_SHADER //a textured shader with lighting

//define the required variables
uniform mat4 modelview;	//the modelview projection
uniform mat4 transform; //the matrix of the modelview*projection result, used to transform to clip coordinates position
uniform mat3 normalMatrix;	//the matrix normal to the vertex

uniform vec4 lightPosition; //position of the light source
uniform vec3 lightNormal;	//position of the light source normal

attribute vec4 vertex;	//position of the current vertex
attribute vec4 color;	//color of the current vertex
attribute vec3 normal;	//normal of the current 

varying vec4 vertColor;	//the vertex colour to be passed to the fragment shader
varying vec3 ecNormal;	//the vertex colour to be passed to the fragment shader
varying vec3 lightDir;	//the vertex colour to be passed to the fragment shader

void main(){
	gl_Position = transform * vertex;	//vertex in clip coordinates
	//first convert the vectors into the same coordinate system
	vec3 ecVertex = vec3(modelview * vertex); //vertex in eye coordinates
	//values to be bassed to fragment shader
	ecNormal = normalize(normalMatrix * normal);	//normal vector in eye coordinates
	lightDir = normalize(lightPosition.xyz - ecVertex);	//direction vector for the light
	vertColor = color;
}