
#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

// viewport resolution (in pixels)
uniform vec2  sketchSize;      

uniform sampler2D bg;    // Source (background)
uniform sampler2D current;    // Current image

// Resolution of the textures
uniform vec2 topLayerResolution;
uniform vec2 lowLayerResolution;

uniform float threshold;
uniform float opacity;



void main(void)
{
	vec2 uv = gl_FragCoord.xy / sketchSize.xy * vec2(1.0,1.0) + vec2(0.0, 1.0);
	
	// source texture (upper layer) note: y axis is mirrored because of Processing's inverted coordinate system
	vec2 sPos = vec2( gl_FragCoord.x / topLayerResolution.x, 1-(gl_FragCoord.y / topLayerResolution.y) );
	vec3 s = texture2D(bg, sPos ).rgb;
	
	// destination texture (lower layer) note: y axis is mirrored because of Processing's inverted coordinate system
    vec2 dPos = vec2( gl_FragCoord.x / lowLayerResolution.x, (gl_FragCoord.y / lowLayerResolution.y) );
	vec3 d = texture2D(current, dPos ).rgb;

	vec4 c = vec4(.0 , .0, .0, .0);

	if (d.r < s.r + threshold && d.r > s.r - threshold &&
		d.g < s.g + threshold && d.g > s.g - threshold &&
		d.b < s.b + threshold && d.b > s.b - threshold
		){
		c += vec4(s.r, s.g, s.b, 0.0);
	}
	else {
		c += vec4(d.r, d.g, d.b, opacity);
	}

	

	gl_FragColor = c;
}
