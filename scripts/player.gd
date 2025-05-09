extends CharacterBody2D


const SPEED := 300.0


var acceleration := 0.0

const BULLET = preload("res://scenes/bullet.tscn")
#func _input(event: InputEvent) -> void:
	#if event in InputEventMouseButton:
		#if event.
@onready var bullets: Node2D = $bullets
@onready var delay: Timer = $delay

@onready var left: Marker2D = $shootpos/left
@onready var right: Marker2D = $shootpos/right

@onready var camera_2d: Camera2D = $"../Camera2D"

@onready var tleft: Line2D = $trails/left
@onready var tright: Line2D = $trails/right

@onready var damage_audio: AudioStreamPlayer = $damage
@onready var shoot_audio: AudioStreamPlayer = $shoot

@onready var logger: Node2D = $"../Logger"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#look_at(get_global_mouse_position())
	var mouse := get_global_mouse_position()
	rotation = lerp_angle(rotation,atan2(global_position.y - mouse.y,global_position.x - mouse.x),0.5)
	var direction := Input.get_vector("left", "right","up","down").normalized()
	if direction:
		acceleration = lerp(acceleration,SPEED/3,delta*2)
		#acceleration = clamp(acceleration, 0.0, 2.0)
		
		#velocity.x = direction.x * ((SPEED / 2) + acceleration)
		#velocity.y = direction.y * ((SPEED / 2)+ acceleration)
		#velocity.x = 100
		velocity.x = lerpf(velocity.x,direction.x * SPEED, delta*8)
		velocity.y = lerpf(velocity.y,direction.y * SPEED, delta*8)
	else:
		velocity.x = lerpf(velocity.x, 0, delta*6)
		velocity.y = lerpf(velocity.y, 0, delta*6)
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) || Input.is_key_pressed(KEY_SPACE):
		if delay.is_stopped():
			shoot()
	else:
		shoot_audio.stop()
	trail()
	
	
	
	move_and_slide()
	
@onready var tleftpos: Marker2D = $trailpos2/left
@onready var trightpos: Marker2D = $trailpos2/right

var trailframe = 0
func trail():
	if tleft.get_point_count() > 5:
			tleft.remove_point(0)
			tright.remove_point(0)
	tleft.add_point(tleftpos.global_position)
	tright.add_point(trightpos.global_position)
	
	#tleft.rotation = rotation
	#tright.rotation = rotation
	#tleft.global_position = global_position
	
	

func shoot():
	if !shoot_audio.playing:
		shoot_audio.play()
	var mouse := get_global_mouse_position()
	var diffy = global_position.y - mouse.y
	var diffx = global_position.x - mouse.x
	var tooclose = (diffy <= 15 && diffy >= -15) && (diffx <= 15 && diffx >= -15)
	camera_2d.shake(0.05,2)
	
	var bullet = BULLET.instantiate()
	bullet.dir = rotation if tooclose else atan2(left.global_position.y - mouse.y,left.global_position.x - mouse.x)
	bullet.global_position = left.global_position
	bullet.rotation = global_rotation
	bullets.add_child(bullet)
	
	var bullet2 = BULLET.instantiate()
	bullet2.dir = rotation if tooclose else atan2(right.global_position.y - mouse.y,right.global_position.x - mouse.x)
	bullet2.global_position = right.global_position
	bullet2.rotation = global_rotation
	bullets.add_child(bullet2)
	
	
	delay.start()
	pass

func damage():
	camera_2d.shake(1,10)
	$damage.play()
	logger.add("ouch",global_position,Color.from_rgba8(255,0,90))
	#damage_audio.play()
	Global.health -= 1
	if Global.health <= 0:
		die()

func die():
	#hide()
	pass		
	
