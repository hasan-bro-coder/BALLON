extends Enemy

@onready var ray: RayCast2D = $RayCast2D

const BULLET = preload("res://scenes/enemys/enemybullet.tscn")

@onready var delay: Timer = $delay

func _ready() -> void:
	soft_collision_strength = 100

func _physics_process(delta: float) -> void:
	if died:
		return
	rotation = lerp_angle(rotation,atan2(global_position.y - player.global_position.y,global_position.x - player.global_position.x),0.5)
	
	if ray.is_colliding():
		if ray.get_collider() == player:
			if delay.is_stopped():
				shoot()
	
	var diffx = global_position.x - player.global_position.x
	var diffy = global_position.y - player.global_position.y
	if (diffx > 100 || diffx < -100) && (diffy > 100 || diffy < -100):
		velocity = (global_position - player.global_position).normalized() * -3000 * delta
		velocity -= knockback
	else:
		velocity.x = lerpf(velocity.x, 0, delta*6)
		velocity.y = lerpf(velocity.y, 0, delta*6)
		velocity = -knockback
	knockback = Vector2.ZERO
	apply_soft_collision(delta)
	move_and_slide()

func shoot():
	var bullet = BULLET.instantiate()
	bullet.dir = rotation
	bullet.global_position = global_position
	bullet.rotation = global_rotation
	#get_parent()
	$"../../".add_child(bullet)
	
	delay.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		apply_soft_collision(1)
	#if body == player:
		##body.damage()
		#queue_free()
	pass # Replace with function body.
