extends Node

const WALKER = preload("res://scenes/enemys/walker.tscn")
const SHOOTER = preload("res://scenes/enemys/shooter.tscn")
const BOMBER = preload("res://scenes/enemys/bomber.tscn")
var enemytypes: Array[PackedScene] = [WALKER
#,SHOOTER,BOMBER
]
var enemys_on_map: Dictionary[String,Enemy] = {
	
}

@export var enemy_count = 5

func generate_unique_id(length := 6) -> String:
	const CHAR_POOL := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var id := ""
	for i in length:
		id += CHAR_POOL[randi() % CHAR_POOL.length()]
	return id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn_group()
	
	pass # Replace with function body.
func spawn_group():
	if len(enemys_on_map) == 0:
		for i in enemy_count:
			await get_tree().create_timer(0.5).timeout
			spawn()
func spawn():
	var enemy = enemytypes.pick_random().instantiate()
	var pos = Vector2(randi_range((1280/2)-($"../ballon".radius / 2),(1280/2)+($"../ballon".radius / 2)),300)
	enemy.global_position = pos
	$CPUParticles2D.global_position = pos
	$CPUParticles2D.emitting = true
	var id = generate_unique_id()
	enemy.name = id
	enemy.die.connect(func(did):
		#print(enemys_on_map)
		if enemys_on_map.has(did):
			enemys_on_map.erase(did)
	)
	add_child(enemy)
	enemys_on_map[id] = enemy
	

func _on_timer_timeout() -> void:
	spawn_group()
	pass # Replace with function body.
