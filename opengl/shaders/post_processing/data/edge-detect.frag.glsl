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

const vec4 luminance_cutoff = vec4(0.5, 0.5, 0.5, 0); //define a cutoff colour

void main(){
	//grab the relevant texels from top left to bottom right around the center point
	//coordinates of the centre texel + some offset 
	//generate the texel neighbourhood for the current texel coordinate
	vec2 pt0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);	//top left
	vec2 pt1 = vertTexCoord.st + vec2(0, -texOffset.t);				//top center
	vec2 pt2 = vertTexCoord.st + vec2(texOffset.s, -texOffset.t);	//top right
	vec2 pt3 = vertTexCoord.st + vec2(-texOffset.s, 0);				//left 
	vec2 pt4 = vertTexCoord.st + vec2(0, 0);						//center texel
	vec2 pt5 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);	//right
	vec2 pt6 = vertTexCoord.st + vec2(-texOffset.s, texOffset.t);	//bottom left
	vec2 pt7 = vertTexCoord.st + vec2(0, texOffset.t);				//bottom center
	vec2 pt8 = vertTexCoord.st + vec2(texOffset.s, texOffset.t);	//bottom right

	//get the color at each of these texel positions
	vec4 col0 = texture2D(texture, pt0);
	vec4 col1 = texture2D(texture, pt1);
	vec4 col2 = texture2D(texture, pt2);
	vec4 col3 = texture2D(texture, pt3);
	vec4 col4 = texture2D(texture, pt4);
	vec4 col5 = texture2D(texture, pt5);
	vec4 col6 = texture2D(texture, pt6);
	vec4 col7 = texture2D(texture, pt7);
	vec4 col8 = texture2D(texture, pt8);
  	
  	vec4 sum = 8.0 * col4 - (col0 + col1 + col2 + col3 + col5 + col6 + col7 + col8); 
  	gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}