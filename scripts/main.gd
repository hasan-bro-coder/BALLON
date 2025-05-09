extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global._reset()
	$Transition.play("open",func():pass)
	Global.set_stage(0)
	get_viewport().size_changed.connect(_resize)
	pass # Replace with function body.

func _resize():
	$CanvasLayer/ColorRect.material.set_shader_parameter("resolution",get_viewport().size)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # Replace with function body.
