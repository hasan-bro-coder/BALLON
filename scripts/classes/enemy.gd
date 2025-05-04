extends CharacterBody2D
class_name Enemy


@onready var area: Area2D = $Area2D
@onready var player: CharacterBody2D = $"../../player"
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var health: int = 10
var soft_collision_strength: float = 800
const SPEED: float = 300.0
var knockback: Vector2 = Vector2.ZERO

func apply_soft_collision(delta) -> void:
	for collider in area.get_overlapping_bodies():
		if collider.is_in_group("enemy"):
			velocity += collider.global_position.direction_to(global_position).normalized() * soft_collision_strength * delta

var scoreAdd = 300

var tween: Tween
var tween2: Tween

func apply_knockback(from_position: Vector2, strength: float):
	#var direction = (global_position - from_position).normalized()
	var direction = (velocity - from_position).normalized()
	knockback = direction * strength

func damage(pos):
	
	#print("damage")
	health -= 1
	if health <= 0:
		Global.score += scoreAdd
		queue_free()
	apply_knockback(pos,700)
	move_and_slide()
	if tween: tween.stop()
	tween = create_tween()
	sprite_2d.material.set_shader_parameter("flash",0.0)
	tween.tween_property(sprite_2d,"material:shader_parameter/flash",1,0.1)
	tween.finished.connect(func():
		if tween2: tween2.stop()
		tween2 = create_tween()
		tween2.tween_property(sprite_2d,"material:shader_parameter/flash",0,0.1)
	)
	#sprite_2d.material.set_shader_parameter("flash",1.0)
		
