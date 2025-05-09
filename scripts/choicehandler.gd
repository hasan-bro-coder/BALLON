extends Node


signal choice_done

const CHOICE = preload("res://scenes/choice.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _add():
	var c = CHOICE.instantiate()
	
	c.global_position.x += (1280/2) + 40
	c.global_position.y += (720/2)
	c.choice_done.connect(
		func():
			choice_done.emit()
			c.queue_free()
	)
	add_child(c)
	
	var c2 = CHOICE.instantiate()
	
	c2.global_position.x += (1280/2) - 40
	c2.global_position.y += (720/2)
	c2.choice_done.connect(func():
			choice_done.emit()
			c.queue_free()
	)
	add_child(c2)
	
	
