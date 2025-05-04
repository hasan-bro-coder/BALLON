shader_type canvas_item;

uniform float flash: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
	//if (COLOR == vec4(1,0,0.353,1)){
	vec4 color = texture(TEXTURE,UV);
	color.rgb = mix(color.rgb,vec3(1,1,1),flash);
	COLOR = color;
	//}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
