//adapted from https://github.com/mattdesl/lwjgl-basics/wiki/ShaderLesson5
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
//define the processing defined variables
uniform sampler2D texture;
uniform vec2 texOffset;	//resolution of the texture
varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 dir;	//direction to apply filter, a vector of 1,0 means horiz, 0,1 means vertical
uniform float radius;	//radius of the blur

//array of pixel weights generated from pascal triangle
const float w0 = 0.2270270270, w1 = 0.1945945946, w2 = 0.1216216216, w3 = 0.0540540541, w4 = 0.0162162162;

void main(){
	vec4 col = vec4(0.0);	//initialize the color
	//calculate how far from the centrepoint to sample
	//float blur = radius / texOffset;
	vec2 offsets = radius * texOffset.st;	//calculate the texel offsets based on the radius of the blur to be used
	//apply the filter to the left
	col += texture2D(texture, vec2(vertTexCoord.s - 4.0 * offsets.x * dir.x, vertTexCoord.t - 4.0 * offsets.y * dir.y)) * w4;
	col += texture2D(texture, vec2(vertTexCoord.s - 3.0 * offsets.x * dir.x, vertTexCoord.t - 3.0 * offsets.y * dir.y)) * w3;
	col += texture2D(texture, vec2(vertTexCoord.s - 2.0 * offsets.x * dir.x, vertTexCoord.t - 2.0 * offsets.y * dir.y)) * w2;
	col += texture2D(texture, vec2(vertTexCoord.s - 1.0 * offsets.x * dir.x, vertTexCoord.t - 1.0 * offsets.y * dir.y)) * w1;

	//center texel
	col += texture2D(texture, vertTexCoord.st) * w0;

	//apply the filter to the right
	col += texture2D(texture, vec2(vertTexCoord.s + 1.0 * offsets.x  * dir.x, vertTexCoord.t + 1.0 * offsets.y * dir.y)) * w1;
	col += texture2D(texture, vec2(vertTexCoord.s + 2.0 * offsets.x  * dir.x, vertTexCoord.t + 2.0 * offsets.y * dir.y)) * w2;
	col += texture2D(texture, vec2(vertTexCoord.s + 3.0 * offsets.x  * dir.x, vertTexCoord.t + 3.0 * offsets.y * dir.y)) * w3;
	col += texture2D(texture, vec2(vertTexCoord.s + 4.0 * offsets.x  * dir.x, vertTexCoord.t + 4.0 * offsets.y * dir.y)) * w4;	
	//apply the blur to the current fragment
  	gl_FragColor = vec4(col.rgba) * vertColor;
}