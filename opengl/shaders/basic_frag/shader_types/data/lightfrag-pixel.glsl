//per pixel lighting calculations
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

//define the typr of shader to he used
#define PROCESSING_LIGHT_SHADER

varying vec4 vertColor; //built in vertex colour, passed from vertex shader
varying vec3 ecNormal;
varying vec3 lightDir;

void main() {
	vec3 direction = normalize(lightDir);
	vec3 normal = normalize(ecNormal);
	float intensity = max(0.0, dot(direction, normal));
  	// Outputting pixel color (interpolated across triangle)
  	gl_FragColor = vec4(intensity, intensity, intensity, 1) * vertColor; 
}