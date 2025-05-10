extends Node2D

const MAIN = preload("res://scenes/mainmenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Transition.play("open",func():$VideoStreamPlayer.play())
	$CanvasLayer/Control/score.text = str(Global.score) + " Pa"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	$VideoStreamPlayer.paused = true
	$Transition.play("close",func():
		get_tree().change_scene_to_packed(MAIN)	
	)
	pass # Replace with function body.
