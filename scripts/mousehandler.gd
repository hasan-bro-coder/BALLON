extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@onready var sprite_2d: Sprite2D = $Sprite2D

var tilt := 15.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse = get_global_mouse_position() - Vector2(4,4)
	var diff = mouse.x - sprite_2d.global_position.x
	if diff > 25.0:
		sprite_2d.rotation_degrees = lerp(sprite_2d.rotation_degrees,tilt,delta * 15)
	elif diff < -25.0:
		sprite_2d.rotation_degrees = lerp(sprite_2d.rotation_degrees,-tilt,delta * 15)
	else:
		sprite_2d.rotation_degrees = lerp(sprite_2d.rotation_degrees,0.0,delta * 15)
	sprite_2d.global_position = lerp(sprite_2d.global_position,mouse,delta*15)
	pass
