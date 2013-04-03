//calculate grayscale by using 1/3 of each color component
//custom variables passed in
uniform float r_off;

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER
//define the processing defined variables
uniform sampler2D texture;
uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(){
	//grab the colour at the texel for each offset
	vec4 col = texture2D(texture, vertTexCoord.st);	
  	vec3 mask = vec3(0.33333, 0.33333, 0.33333);
  	//use the dot product to multiply the 2 vectors and get a value
  	float intensity = dot(col.rgb, mask);

  	//vec2 pos = gl_FragCoord.xy;
  	//vec4 sum = 8.0 * col4 - (col0 + col1 + col2 + col3 + col5 + col6 + col7 + col8); 
  	gl_FragColor = vec4(intensity, intensity, intensity, 1.0);
}