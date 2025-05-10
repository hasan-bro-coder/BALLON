extends Enemy

@onready var delay: Timer = $delay

const BULLET = preload("res://scenes/enemys/enemybullet.tscn")

var speed = 4
@onready var cp: CPUParticles2D = $CPUParticles2D2

func _ready() -> void:
	velocity = Vector2(-speed,speed)


func _physics_process(delta: float) -> void:
	apply_soft_collision(delta)
	velocity = velocity.clamp(Vector2(-speed,-speed),Vector2(speed,speed))
	var c = move_and_collide(velocity)
	if c:
		cp.emitting = true
		#if !c.get_collider().is_in_group("enemy"):
		velocity = velocity.bounce(c.get_normal())
#func _physics_process(delta: float) -> void:
	#if died:
		#return
	#rotation = lerp_angle(rotation,atan2(global_position.y - player.global_position.y,global_position.x - player.global_position.x),0.5)
	#velocity = (global_position - player.global_position).normalized() * -3000 * delta 
	#velocity -= knockback
	#knockback = Vector2.ZERO
	#
	#apply_soft_collision(delta)
	#move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if died:
		return
	if body == player:
		body.damage()
	pass # Replace with function body.

func shoot_bullet():
	shoot(0)
	shoot(1)
	shoot(2)
	shoot(3)

func shoot(dir):
	var bullet = BULLET.instantiate()
	bullet.speed = 200
	bullet.dir = dir * 90 if dir != 0 else rotation_degrees
	var ps = Vector2.ZERO
	match dir:
		1:
			ps = Vector2(0,-50)
		2:
			ps = Vector2(50,0)
		3:
			ps = Vector2(0,50)
		0:
			ps = Vector2(-50,0)
	bullet.global_position = global_position + ps
	bullet.global_rotation = dir * 90
	$"../../../".add_child.call_deferred(bullet,true)

	


func _on_delay_timeout() -> void:
	shoot_bullet()
	pass # Replace with function body.
