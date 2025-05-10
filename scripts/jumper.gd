extends Enemy

var dir: Vector2
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
	#if velocity.y > 0 and velocity.y < 10:
		#velocity.y = -speed
	#if velocity.x == 0:
		#velocity.x = -speed
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		body.damage()
		damage(global_position,false)
	pass # Replace with function body.
