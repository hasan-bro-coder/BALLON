extends Node2D

const MAIN = preload("res://scenes/mainmenu.tscn")
# Called when the node enters the scene tree for the first time.
var vid = preload("res://assets/cutscene/last.ogg")
func _ready() -> void:
	var t = create_tween()
	t.tween_property($CanvasLayer/ColorRect,"color",Color.TRANSPARENT,3)
	t.finished.connect(func():
		$CanvasLayer/VideoStreamPlayer.stream = vid
		$CanvasLayer/VideoStreamPlayer.play()
		$CanvasLayer/TextureRect.texture = load("res://assets/cutscene/finish.png")
	)
	$CanvasLayer/Control/score.text = str(Global.score) + " Pa"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_video_stream_player_finished() -> void:
	$CanvasLayer/Control.show()
	pass # Replace with function body.
