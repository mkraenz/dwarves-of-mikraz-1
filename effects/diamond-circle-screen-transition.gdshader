// based on https://godotshaders.com/shader/screentone-scene-transition/
shader_type canvas_item;
render_mode unshaded;


uniform vec4 color: source_color;

uniform float position:hint_range(-1.5,1.) = 1.0;
uniform vec2 size = vec2(16., 16.);

void fragment(){
    vec2 a = (1./SCREEN_PIXEL_SIZE) / size;
    
    vec2 uv=UV;
    uv *= a;
    
    vec2 i_uv = floor(uv);
    vec2 f_uv = fract(uv);
    
    float wave = max(0.,i_uv.x/(a.x) - position);
    
    vec2 center = f_uv*2.-1.;
    float circle = length(center);
    circle = 1. - step(wave,circle);
	
    
    COLOR=vec4(circle) * color;
}