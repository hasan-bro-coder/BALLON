extends CharacterBody2D
class_name Enemy

signal die(name: String)

@onready var area: Area2D = $Area2D
@onready var player: CharacterBody2D = $"../../player"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var dieparticle: GPUParticles2D = $die

@export var health: int = 10
var soft_collision_strength: float = 800
const SPEED: float = 300.0
var knockback: Vector2 = Vector2.ZERO

func apply_soft_collision(delta) -> void:
	
	if !area:
		return
	for collider in area.get_overlapping_bodies():
		if collider.is_in_group("enemy"):
			velocity += collider.global_position.direction_to(global_position).normalized() * soft_collision_strength * delta

var scoreAdd = 300

var tween: Tween
var tween2: Tween

var playit = true

var died = false

func _ready() -> void:
	audio.finished.connect(audio_signal)

func audio_signal():
	if playit:
		audio.pitch_scale = randf_range(0.9,1.10)
		audio.play()
	playit = false
	

func apply_knockback(from_position: Vector2, strength: float):
	#var direction = (global_position - from_position).normalized()
	var direction = (velocity - from_position).normalized()
	knockback = direction * strength

func damage(pos):
	if !audio.playing:
		audio.pitch_scale = randf_range(0.9,1.10)
		audio.play()
		playit = true
		
		
		
	health -= 1
	if health <= 0:
		Global.score += scoreAdd
		died = true
		#dieparticle.emitting = true
		die.emit(name)
		sprite_2d.hide()
		#await dieparticle.finished
		await audio.finished
		queue_free()
	apply_knockback(pos,500)
	move_and_slide()
	
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
		
