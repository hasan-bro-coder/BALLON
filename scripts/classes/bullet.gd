extends CharacterBody2D
class_name Bullet


@export var speed := 500
var dir: float

var timer := 5.0

func _physics_process(delta: float) -> void:
	timer-= delta
	velocity = Vector2(-speed,0).rotated(dir)
	move_and_slide()
	if timer < 0:
		queue_free()
		
	#for i in get_slide_collision_count():
			#var c = get_slide_collision(i)
			#if c.get_collider() is RigidBody2D:
				#c.get_collider().apply_central_impulse(c.get_normal() * 800)
	pass
