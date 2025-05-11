extends Camera2D

@export var shake_duration := 0.5
@export var shake_strength := 10.0

var _time_left := 0.0
var _original_offset := Vector2.ZERO
@onready var player: CharacterBody2D = $"../player"
@export var smooth_speed: float = 5.0
@export var deadzone_size: Vector2 = Vector2(100, 60)

func _ready():
	_original_offset = offset

var zoom_to := Vector2(2,2)

func _process(delta):
	
	if zoom != zoom_to:
		zoom = lerp(zoom,zoom_to,delta/2)
	
	if _time_left > 0:
		_time_left -= delta
		offset = _original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = _original_offset
		
	var target_pos = player.global_position
	var cam_pos = global_position
	var offset2 = target_pos - cam_pos

	var dx = offset2.x
	var dy = offset2.y

	var move = Vector2.ZERO

	if abs(dx) > deadzone_size.x:
		move.x = dx - sign(dx) * deadzone_size.x
	if abs(dy) > deadzone_size.y:
		move.y = dy - sign(dy) * deadzone_size.y

	global_position += move * smooth_speed * delta
	
	#global_position = lerp(global_position, player.global_position, 5 * delta)

#func zoom_to()

func shake(duration := 0.5, strength := 10.0):
	shake_duration = duration
	shake_strength = strength
	_time_left = shake_duration
