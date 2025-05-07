shader_type canvas_item;

uniform float flash = 0;

void fragment(){
	vec4 color = texture(TEXTURE,UV);
	color.rgb = mix(color.rgb,vec3(1,1,1).rgb,flash);
	COLOR = color;
}