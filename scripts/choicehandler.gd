extends Node2D


signal choice_done

const CHOICE = preload("res://scenes/choice.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var cd = false

func _add():
	cd = false
	$Label.show()
	var c = CHOICE.instantiate()
	var c2 = CHOICE.instantiate()
	
	while c.data == c2.data:
		c.change_data(randi_range(1,3))
	
	add_child(c)
	add_child(c2)
	
	c.global_position.x += (1280/2) + 60
	c.global_position.y += (720/2)
	c.hover.connect(
		func(data):
			$Label.text = data
	)
	c.choice_done.connect(
		func():
			if !cd:
				choice_done.emit()
				cd = true
			c2.queue_free()
			$Label.hide()
	)
	
	
	c2.global_position.x += (1280/2) - 60
	c2.global_position.y += (720/2)
	c2.hover.connect(
		func(data):
			$Label.text = data
	)
	c2.choice_done.connect(func():
			if !cd:
				choice_done.emit()
				cd = true
			c.queue_free()
			$Label.hide()
	)
	
	
