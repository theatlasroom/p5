	
#define PROCESSING_TEXLIGHT_SHADER //a textured shader with lighting

//define the required variables
uniform mat4 modelview;	//the modelview projection
uniform mat4 transform; //the matrix of the modelview*projection result, used to transform to clip coordinates position
uniform mat3 normalMatrix;	//the matrix normal to the vertex
uniform mat4 texMatrix;	//the texture matrix 

uniform vec4 lightPosition; //position of the light source

attribute vec4 vertex;	//position of the current vertex
attribute vec4 color;	//color of the current vertex
attribute vec3 normal;	//normal of the current 
attribute vec2 texCoord; //texture coordinates for the vertex

varying vec4 vertColor;	//the vertex colour to be passed to the fragment shader
varying vec4 vertTexCoord; //vertex texture coords passed onto the fragment shader

void main(){
	gl_Position = transform * vertex;	//vertex in clip coordinates
	//first convert the vectors into the same coordinate system
	vec3 ecVertex = vec3(modelview * vertex); //vertex in eye coordinates
	vec3 ecNormal = normalize(normalMatrix * normal);	//normal vector in eye coordinates	
	//values to be bassed to fragment shader
	vec3 direction = normalize(lightPosition.xyz - ecVertex);	//direction vector for the light
	float intensity = max(0.0, dot(direction, ecNormal));
	vertColor = vec4(intensity, intensity, intensity, 1) * color;

	vertTexCoord = texMatrix * vec4(texCoord, 1.0, 1.0);
}	