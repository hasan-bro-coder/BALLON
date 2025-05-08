extends Node




var stage: = 0
var stage_state = [
	{
		"zoom": Vector2(2,2),
		"radius": 150,
		"scoreNext": 10000,
		"scoreExt": 0
	},
	{
		"zoom": Vector2(1.7,1.7),
		"radius": 225,
		"scoreNext": 50000,
		"scoreExt": 10000
	},
	{
		"zoom": Vector2(1.2,1.2),
		"radius": 300,
		"scoreNext": 150000,
		"scoreExt": 50000
	},
	{
		"zoom": Vector2(1,1),
		"radius": 400,
		"scoreNext": 300000,
		"scoreExt": 150000
	}
]
var enemyspawnrate = 100

var score = 0:
	set(value):
		var scoreLabel: Label = $"../main/scores/Control/score"
		var ballon: Node2D = $"../main/ballon"
		scoreLabel.text = str(value)
		if value >= stage_state[stage]["scoreNext"]:
			ballon.fill(20)
			set_stage(stage+1)
		else:
			ballon.fill((floor(((value-stage_state[stage]["scoreExt"])*20))/(stage_state[stage]["scoreNext"]-stage_state[stage]["scoreExt"])))
		score = value


var health = 5:
	set(value):
		var health_bar: HBoxContainer = $"../main/scores/Control/HBoxContainer"
		var heart: TextureRect = $"../main/scores/Control/TextureRect"
		if value == 0:
			for i in health_bar.get_child_count():
				health_bar.get_child(i).queue_free()
				health = value
				$"../main/died/Control/score".text = "score: "+str(score)
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
	#$"../main/ballon".ready.connect(func(): 
		#set_stage(0)
	#)
	pass

func set_stage(i):
	$"../main/Camera2D".zoom_to = stage_state[i]["zoom"]
	$"../main/ballon".radius = stage_state[i]["radius"]
	stage = i
	$"../main/ballon".fill(0)
	$"../main/ballon".build()
	#$"../main/ballon".build()
