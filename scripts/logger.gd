extends Node2D

@onready var label: Label = $Label
@onready var labels: Node2D = $labels

func add(text: String,pos: Vector2,color: Color = Color.WHITE):
	var l = label.duplicate()
	l.global_position = pos
	l.text = text
	l.label_settings.font_color = color
	#["theme_override_colors/font_color"] = color
	l.show()
	labels.add_child(l)
	var t = create_tween()
	var t2 = create_tween()
	t.tween_property(l,"global_position",pos-Vector2(0,30),1)
	t2.tween_property(l,"modulate",Color.TRANSPARENT,1)
	await t.finished
	l.queue_free()
	
	
