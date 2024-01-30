shader_type canvas_item;

uniform vec4 laser_color: source_color = vec4(0.91, 0.2, 1.0, 1.0);
uniform float speed = 0.5;
uniform float progress: hint_range(0.0, 1.0, 0.01) = 0;
uniform sampler2D beam_noise: source_color;
uniform sampler2D progress_noise: source_color;


void vertex() {
	// Called for every vertex the material is visible on.
}

float random(vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) *
            43758.5453123);
}

vec4 beam(vec2 uv, float time) {
	vec4 beam_color = laser_color;
	//beam_color.a = clamp((0.8-uv.x), 0, beam_color.a);
	//beam_color.a = clamp((uv.x-0.2) * 3.0, 0, beam_color.a);
	//beam_color.a = clamp(progress - uv.y, 0, beam_color.a);
	vec4 noise_tex = texture(beam_noise, uv + (vec2(0,1) * TIME * speed));
	//vec4 progress_tex = texture(progress_noise, vec2(uv.x, uv.y - 0.1 * cos(TIME)));
	return (beam_color * noise_tex);
}

void fragment() {
	vec4 beam_color = vec4(0.0);
	COLOR = beam(UV, TIME);
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
