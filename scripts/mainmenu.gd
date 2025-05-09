extends Node2D

@onready var sprite_2d: Sprite2D = $balloneffect/Sprite2D
@onready var balloncon: Node2D = $balloneffect
@onready var hover: AudioStreamPlayer = $hover
@onready var click: AudioStreamPlayer = $click

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Transition.play("open",func():)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

@onready var anime: AnimationPlayer = $AnimationPlayer

func _on_button_pressed() -> void:
	click.play()
	#var tween = create_tween()
	#$CanvasLayer/Control/TextureRect.modulate = Color.from_rgba8(255,0,99)
	#tween.tween_property($CanvasLayer/ColorRect, "color", Color.BLACK, 2)
	$Transition.play("close",func():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	)
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	hover.play()
	var tween = create_tween()
	#$CanvasLayer/Control/TextureRect.modulate = Color.from_rgba8(255,0,99)
	tween.tween_property($CanvasLayer/Control/TextureRect, "modulate", Color.from_rgba8(255,0,99), 0.2)
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($CanvasLayer/Control/TextureRect, "modulate", Color.WHITE, 0.2)

	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var s = sprite_2d.duplicate()
	s.zoom = randi_range(1,5)
	
	s.global_position = Vector2(randi_range(0,1280),750)
	balloncon.add_child(s)
	pass # Replace with function body.
