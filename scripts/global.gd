extends Node




var stage: = 0
#var stage_state = [
	#{
		#"zoom": Vector2(2,2),
		#"radius": 150,
		#"scoreNext": 5000,
		#"scoreExt": 0
	#},
	#{
		#"zoom": Vector2(1.7,1.7),
		#"radius": 200,
		#"scoreNext": 15000,
		#"scoreExt": 5000
	#},
	#{
		#"zoom": Vector2(1.5,1.5),
		#"radius": 230,
		#"scoreNext": 30000,
		#"scoreExt": 15000
	#},
	#{
		#"zoom": Vector2(1.4,1.4),
		#"radius": 270,
		#"scoreNext": 40000,
		#"scoreExt": 30000
	#}
#]
var stage_state = [
	{
		"zoom": Vector2(2,2),
		"radius": 150,
		"scoreNext": 1000,
		"scoreExt": 0
	},
	{
		"zoom": Vector2(1.7,1.7),
		"radius": 200,
		"scoreNext": 2000,
		"scoreExt": 1000
	},
	{
		"zoom": Vector2(1.5,1.5),
		"radius": 230,
		"scoreNext": 3000,
		"scoreExt": 2000
	},
	{
		"zoom": Vector2(1.4,1.4),
		"radius": 270,
		"scoreNext": 40000,
		"scoreExt": 3000
	}
]


var scoreM = 1
var damage = 0

var score_done = false

var score = 0:
	get():
		return int(score)
	set(value):
		
		score = value
		var scoreLabel: Label = $"../main/scores/Control/score"
		var ballon: Node2D = $"../main/ballon"
		if !scoreLabel:
			return
		scoreLabel.text = str(int(value)) + " Pa"
		if value >= stage_state[stage]["scoreNext"]:
			ballon.fill(20)
			if score_done == false:
				set_stage(stage+1)
				score_done = true
		else:
			ballon.fill((floor(((value-stage_state[stage]["scoreExt"])*20))/(stage_state[stage]["scoreNext"]-stage_state[stage]["scoreExt"])))


var health = 5:
	set(value):
		var health_bar: HBoxContainer = $"../main/scores/Control/HBoxContainer"
		var heart: TextureRect = $"../main/scores/TextureRect"
		if !heart:
			return
		if value == 0:
			for i in health_bar.get_child_count():
				health_bar.get_child(i).queue_free()
				health = value
				#$"../main/died/Control/score".text = "score: "+str(score)
				#$"../main/died".show()
				
				#get_tree().paused = true
			return
		health = min(value,7)
		for i in health_bar.get_child_count():
			if i == 0: continue
			health_bar.get_child(i).queue_free()
		for i in value:
			var h = heart.duplicate()
			h.show()
			#print("frame:",i)
			health_bar.add_child(h)
			#h.texture.speed_scale = i
			h.texture.set_current_frame((int(i) + 2) % 8)
		


func _ready() -> void:
	#health = 5
	#$"../main/ballon".ready.connect(func(): 
		#set_stage(0)
	#)
	pass

func _reset():
	stage = 0
	scoreM = 1
	damage = 0
	score = 0
	health = 5
	score_done = false
	
func set_stage(i):
	print("setting stage",i)
	$"../main/Camera2D".zoom_to = stage_state[i]["zoom"]
	$"../main/ballon".radius = stage_state[i]["radius"]
	if i != 0:
		await $"../main/enemyhandler".no_enemy
		$"../main/enemyhandler".wait = true
		$"../main/choicehandler"._add()
		$"../main/choicehandler".choice_done.connect(func():
			await get_tree().create_timer(1).timeout
			if i == 3:
				$"../main/enemyhandler".spawn_boss()
			$"../main/enemyhandler".wait = false
		)
	stage = i
	score_done = false
	$"../main/ballon".fill(0)
	$"../main/ballon".build()
	#$"../main/ballon".build()
