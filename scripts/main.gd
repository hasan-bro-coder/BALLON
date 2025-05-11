extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global._reset()
	$Transition.play("open",func():pass)
	Global.set_stage(0)
	pass # Replace with function body.
