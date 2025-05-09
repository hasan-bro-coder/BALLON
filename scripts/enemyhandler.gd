extends Node

const WALKER = preload("res://scenes/enemys/walker.tscn")
const SHOOTER = preload("res://scenes/enemys/shooter.tscn")
const BOMBER = preload("res://scenes/enemys/bomber.tscn")
const JUMPER = preload("res://scenes/enemys/jumper.tscn")
var enemytypes: Array[PackedScene] = [
	WALKER,
	SHOOTER,
	BOMBER,
	JUMPER
]
var enemys_on_map: Dictionary[String,Enemy] = {
	
}

signal no_enemy()

var wait = false

@onready var audio_spawn: AudioStreamPlayer = $AudioStreamPlayer

@export var enemy_count = 1
@onready var enemys: Node2D = $enemys

func generate_unique_id(length := 6) -> String:
	const CHAR_POOL := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var id := ""
	for i in length:
		id += CHAR_POOL[randi() % CHAR_POOL.length()]
	return id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	no_enemy.emit()
	#spawn_group()
	
	pass # Replace with function body.
	
var emmited = false
func _physics_process(delta: float) -> void:
	if len(enemys_on_map) == 0:
		if !emmited:
			return
		no_enemy.emit()
		emmited = false
	else:
		emmited = true
		
	
func spawn_group():
	if wait:
		return
	if len(enemys_on_map) == 0:
		for i in enemy_count:
			await get_tree().create_timer(0.5).timeout
			spawn()
func spawn():
	if wait:
		return
	var enemy = enemytypes.pick_random().instantiate()
	var pos = Vector2(randi_range((1280/2)-($"../ballon".radius / 2),(1280/2)+($"../ballon".radius / 2)),300)
	enemy.global_position = pos
	$CPUParticles2D.global_position = pos
	$CPUParticles2D.emitting = true
	audio_spawn.play()
	var id = generate_unique_id()
	enemy.name = id
	enemy.die.connect(func(did):
		if enemys_on_map.has(did):
			enemys_on_map.erase(did)
	)
	enemys.add_child(enemy)
	enemys_on_map[id] = enemy
	

func _on_timer_timeout() -> void:
	if wait:
		return
	spawn_group()
	pass # Replace with function body.
