extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var tween = create_tween()
	#$CanvasLayer/Control/TextureRect.modulate = Color.from_rgba8(255,0,99)
	tween.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 2)
	tween.finished.connect(func():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	)
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	var tween = create_tween()
	#$CanvasLayer/Control/TextureRect.modulate = Color.from_rgba8(255,0,99)
	tween.tween_property($CanvasLayer/Control/TextureRect, "modulate", Color.from_rgba8(255,0,99), 0.2)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($CanvasLayer/Control/TextureRect, "modulate", Color.WHITE, 0.2)

	pass # Replace with function body.
