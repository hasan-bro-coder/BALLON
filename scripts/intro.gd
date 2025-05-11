extends Control

const MAIN = preload("res://scenes/training.tscn")
var vid = preload("res://assets/cutscene/output.ogv")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Transition.play("open",func():
		$VideoStreamPlayer.stream = vid
		$VideoStreamPlayer.play()
		)
	pass # Replace with function body.

const LAST = preload("res://assets/cutscene/last.png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	$TextureRect.texture = LAST
	$VideoStreamPlayer.paused = true
	$Transition.play("close",func():
		get_tree().change_scene_to_packed(MAIN)	
	)
	pass # Replace with function body.
