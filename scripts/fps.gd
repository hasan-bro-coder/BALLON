extends Label


func _physics_process(_delta: float) -> void:
	text = str(Engine.get_frames_per_second())
	pass
