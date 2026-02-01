shader_type spatial;

uniform sampler2D _MainTex : source_color;

vec3 hash33(vec3 p) {
	p = fract(p * 0.4567);
	p += dot(p, p.yzx + 1.3456);
	p.x *= p.x;
	p.y *= p.y;
	p.z *= p.z;
	return fract(p);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 random_color_ws = hash33(NODE_POSITION_WORLD);
	vec3 albedo = texture(_MainTex, UV).rgb;
	ALBEDO = random_color_ws;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
