//threshold filter adapted from http://www.curious-creature.org/2007/02/20/fast-image-processing-with-jogl/
							 // http://en.wikipedia.org/wiki/Luminance
							 // http://gamedev.stackexchange.com/questions/21352/what-is-the-point-of-this-hard-coded-vector-when-calculating-luminance-in-glow-b
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

const vec3 channel_weight = vec3(0.2126, 0.7152, 0.0722);	//threshold levels based on the eyes perception of each colour channel
const float threshold = 0.15;

void main(){
	//dot product the current color with the channel_weight values
	vec4 tex_color = texture2D(texture, vec2(vertTexCoord.st));	//get the texture colour at this point
	float luminance = dot(tex_color.rgb, channel_weight);	//results in a value between 0..255
	if (luminance > threshold)
		gl_FragColor = vec4(tex_color);
	else		
		gl_FragColor = vec4(0.0,0.0,0.0,1.0);
}