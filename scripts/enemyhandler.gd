extends Node

const WALKER = preload("res://scenes/enemys/walker.tscn")
const SHOOTER = preload("res://scenes/enemys/shooter.tscn")
var enemytypes: Array[PackedScene] = [WALKER,SHOOTER]
@export var enemy_count = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in enemy_count:
		spawn()
	pass # Replace with function body.

func spawn():
	var enemy = enemytypes.pick_random().instantiate()
	enemy.global_position = Vector2(randi_range((1280/2)-50,(1280/2)+50),300)
	add_child(enemy)

func _on_timer_timeout() -> void:
	spawn()
	pass # Replace with function body.
