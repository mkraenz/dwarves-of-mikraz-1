shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec2 uv = UV;
	vec4 prevColor = texture(TEXTURE, uv);
	
	vec4 white = vec4(1, 1, 1, prevColor.a);
	if ( active ) COLOR = white;
	else COLOR = prevColor;
}
