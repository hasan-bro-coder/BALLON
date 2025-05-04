extends Camera2D

@export var shake_duration := 0.5
@export var shake_strength := 10.0

var _time_left := 0.0
var _original_offset := Vector2.ZERO

func _ready():
	_original_offset = offset

func _process(delta):
	if _time_left > 0:
		_time_left -= delta
		offset = _original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		offset = _original_offset

func shake(duration := 0.5, strength := 10.0):
	shake_duration = duration
	shake_strength = strength
	_time_left = shake_duration
