extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Transition.play("open")
	$ballon.build()
	train()
	pass # Replace with function body.

func train():
	await get_tree().create_timer(4).timeout
	$CanvasLayer/Label.text = "Use WASD to move"
	await get_tree().create_timer(3).timeout
	$CanvasLayer/Label.text = "Mouse click or Press Space to shoot"
	await get_tree().create_timer(5).timeout
	$CanvasLayer/Label.text = "shoot the enemy"
	var enemy = load("res://scenes/enemys/walker.tscn").instantiate()
	var pos = Vector2(randi_range((1280/2)-($ballon.radius / 2),(1280/2)+($ballon.radius / 2)),randi_range((720/2)-($ballon.radius / 2),(720/2)+($ballon.radius / 2)))
	enemy.global_position = pos
	enemy.health = 50
	$enemycon/enemycon.add_child(enemy)
	await get_tree().create_timer(6).timeout
	$CanvasLayer/Label.text = "killing enemys increases score(air pressure)"
	await get_tree().create_timer(2).timeout
	$CanvasLayer/Label.text = "Good luck"
	await get_tree().create_timer(2).timeout
	$Transition.play("close",func():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	)
	
