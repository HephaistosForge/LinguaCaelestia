shader_type canvas_item;



void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR.a = clamp((0.8-UV.y) * 3.0, 0, COLOR.a);
}

