extends Control

@onready var restart: Button = $restart
@onready var hover: AudioStreamPlayer = $"../../hover"
@onready var click: AudioStreamPlayer = $"../../click"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$score.text = "score: " + str(Global.score) + " Pa"

func _on_restart_pressed() -> void:
	click.play()
	Global._reset()
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
	pass # Replace with function body.


func _on_restart_mouse_entered() -> void:
	hover.play()
	var tween = create_tween()
	#$CanvasLayer/Control/TextureRect.modulate = Color.from_rgba8(255,0,99)
	tween.tween_property($TextureRect, "modulate", Color.from_rgba8(255,0,99), 0.2)
	pass # Replace with function body.
	pass # Replace with function body.


func _on_restart_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($TextureRect, "modulate", Color.WHITE, 0.2)
	pass # Replace with function body.
