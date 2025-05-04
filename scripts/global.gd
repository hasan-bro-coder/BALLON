extends Node

@onready var heart: TextureRect = $"../main/scores/Control/TextureRect"
@onready var health_bar: HBoxContainer = $"../main/scores/Control/HBoxContainer"
@onready var scoreLabel: Label = $"../main/scores/Control/score"
@onready var ballon: Node2D = $"../main/ballon"

var stage: = 0
var stage_state = [
	{
		"zoom": Vector2(1.5,1.5),
		"radius": 200,
		"ballonhealth": 100,
		"scoreNext": 10000
	}
]
var enemyspawnrate = 100

var score = 0:
	set(value):
		if value >= stage_state[stage]["scoreNext"]:
			scoreLabel.text = str(value)
			ballon.fill(30)
		else:
			ballon.fill(floor((value*30)/stage_state[stage]["scoreNext"]))
		score = value


var health = 5:
	set(value):
		if value == 0:
			for i in health_bar.get_child_count():
				health_bar.get_child(i).queue_free()
				health = value
				$"../main/died".show()
				get_tree().paused = true
			return
		for i in health_bar.get_child_count():
			#if i == 0: continue
			health_bar.get_child(i).queue_free()
		for i in value:
			health_bar.add_child(heart.duplicate())
		health = value
var damage = 5
var ballondamage = 5


func _ready() -> void:
	$"../main/ballon".ready.connect(func(): 
		set_stage(0)
	)

func set_stage(i):
	$"../main/Camera2D".zoom = stage_state[i]["zoom"]
	$"../main/ballon".radius = stage_state[i]["radius"]
	#$"../main/ballon".build()
