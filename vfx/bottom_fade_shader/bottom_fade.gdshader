shader_type canvas_item;
//render_mode blend_add;

uniform float bottom_fade_factor = 0.01;
uniform sampler2D shield_pattern;
uniform vec4 shield_color: source_color;
uniform float shield_barrier_thickness = 0.02;
uniform float idle_ripple_progress = 0.0;
uniform float idle_ripple_thickness = 0.1;

void fragment() {
	vec2 center = vec2(0.5);
	float radius = 0.5;
	float dist = distance(center, UV);
	
	// use shield pattern texture
	COLOR = texture(shield_pattern, UV) * shield_color;
	
	// half circular pattern
	if (dist > radius || UV.y > 0.6)  {
		COLOR.a = 0.0;
	}
	// outer ring
	else if (dist > (radius - (0.4 * shield_barrier_thickness))){
		COLOR = shield_color + (0.2 * shield_color);
	}
	// outer shield barrier
	else if (dist > (radius - shield_barrier_thickness)){
		vec3 new_color = clamp(COLOR.rgb + shield_color.rgb, 0.9*shield_color.rgb, COLOR.rgb + (0.2 * shield_color.rgb));
		COLOR += 0.2 * shield_color;
		//COLOR.a = 1.0;
	}
	else if (
		(dist < (idle_ripple_progress * radius) && dist > (idle_ripple_progress * radius) - idle_ripple_thickness && UV.y < 0.5)
		//(UV.y > 0.5 && UV.x > radius - (idle_ripple_progress*radius) && UV.x < radius - (idle_ripple_progress * radius) + idle_ripple_thickness) ||
		//(UV.y > 0.5 && UV.x > radius - (idle_ripple_progress*radius) && UV.x < radius - (idle_ripple_progress * radius) + idle_ripple_thickness) 
		){
		COLOR = shield_color + (0.2 * shield_color);
	}
	// inner shield fade
	else {
		COLOR += 0.05 * shield_color;
		COLOR.a = clamp((dist * 0.25)/radius, 0.0001, COLOR.a);
		
	}
	// bottom fade
	
	COLOR.a = clamp((0.6 - UV.y) * 3.0, 0.0, COLOR.a);
	
}