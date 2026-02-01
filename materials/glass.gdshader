shader_type spatial;

uniform sampler2D glass_texture;
uniform float trasnparency: hint_range(0, 1, 0.1) = 0.2;

void fragment() {
    vec4 glass_color = texture(glass_texture, UV);
	ALPHA = trasnparency;
    ALBEDO = glass_color.rgb;
}