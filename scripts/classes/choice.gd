extends StaticBody2D
class_name Choice

var data = {
	"health": 0,
	"damage": 0,
	"score": 0
}
var health = 15

signal choice_done
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $"../../Camera2D"
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var dieaudio: AudioStreamPlayer = $dieaudio

func _ready() -> void:
	match  randi_range(1,3):
		1:
			data["health"] = randi_range(1,3)
		2:
			data["damage"] = randi_range(1,3)
		3:
			data["score"] = randf_range(0.5,1.5)

func apply():
	print(data)
	if data["health"] != 0:
		Global.health += data["health"]
	if data["damage"] != 0:
		Global.damage += data["damage"]
	if data["score"] != 0:
		Global.scoreM += data["score"]
	choice_done.emit()
	
var tween: Tween
var tween2: Tween


func damage():
	health -= 1
	if health == 0:
		apply()
		camera.shake()
		choice_done.emit()
		sprite_2d.hide()
		#await dieparticle.finished
		dieaudio.play()
		await dieaudio.finished
		queue_free()
	if !audio.playing:
		audio.pitch_scale = randf_range(0.9,1.10)
		audio.play()
	if tween and tween.is_running(): 
		return
		#tween.stop()
	tween = create_tween()
	#sprite_2d.material.set_shader_parameter("flash",0.0)
	#tween.tween_property(self,"scale",Vector2(1.1,1.1),0.2)
	tween.tween_property(sprite_2d,"material:shader_parameter/flash",1,0.1)
	tween.finished.connect(func():
		if tween2: tween2.stop()
		tween2 = create_tween()
		#tween.tween_property(self,"scale",Vector2(1,1),0.2)
		tween2.tween_property(sprite_2d,"material:shader_parameter/flash",0,0.1)
	)
	#sprite_2d.material.set_shader_parameter("flash",1.0)
		
