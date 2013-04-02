#define PROCESSING_LIGHT_SHADER //a textured shader with lighting

//define the required variables
uniform mat4 modelview;	//the modelview projection
uniform mat4 transform; //the matrix of the modelview*projection result, used to transform to clip coordinates position
uniform mat3 normalMatrix;	//the matrix normal to the vertex

uniform vec4 lightPosition; //position of the light source

attribute vec4 vertex;	//position of the current vertex
attribute vec4 color;	//color of the current vertex
attribute vec3 normal;	//normal of the current 

varying vec4 vertColor;	//the vertex colour to be passed to the fragment shader

void main(){
	gl_Position = transform * vertex;	//vertex in clip coordinates
	//first convert the vectors into the same coordinate system
	vec3 ecVertex = vec3(modelview * vertex); //vertex in eye coordinates
	vec3 ecNormal = normalize(normalMatrix * normal);	//normal vector in eye coordinates
	//calculate the light intensity incident on the vertex
	vec3 direction = normalize(lightPosition.xyz - ecVertex);
	//the intensity is directly proportional to the angle between the normal and the vector between the vertex and the light source	
	float intensity = max(0.0, dot(direction, ecNormal));	
	vertColor = vec4(intensity, intensity, intensity, 1) * color;
}