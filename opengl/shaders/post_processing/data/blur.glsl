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
	//top texture pixels
	vec2 top_left = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);
	vec2 top = vertTexCoord.st + vec2(0, -texOffset.t);	
	vec2 top_right = vertTexCoord.st + vec2(texOffset.s, -texOffset.t);	
	//middle texture pixel coords
	vec2 left = vertTexCoord.st + vec2(-texOffset.s, 0);	
	vec2 curr = vertTexCoord.st;	
	vec2 right = vertTexCoord.st + vec2(texOffset.s, 0);	
	//bottom texture pixel coords
	vec2 bottom_left = vertTexCoord.st + vec2(-texOffset.s, texOffset.t);	
	vec2 bottom = vertTexCoord.st + vec2(0, texOffset.t);	
	vec2 bottom_right = vertTexCoord.st + vec2(texOffset.s, texOffset.t);	
	//grab the colour at the texel for each offset
	vec4 col = texture2D(texture, curr);	
	vec4 coll = texture2D(texture, left);	
	vec4 colr = texture2D(texture, right);

	vec4 colt = texture2D(texture, top);	
	vec4 coltl = texture2D(texture, top_left);	
	vec4 coltr = texture2D(texture, top_right);	

	vec4 colb = texture2D(texture, bottom);	
	vec4 colbl = texture2D(texture, bottom_left);	
	vec4 colbr = texture2D(texture, bottom_right);

	vec4 res = (1.0 * (coltl + colbl + coltr + colbr) + 2.0 * (coll + colr + colt + colb) + 3.0 * col)/15.0;
	//vec4 res = vec4(1.0,1.0,1.0,1.0);
  	gl_FragColor = vec4(res.rgb, 1.0);
}