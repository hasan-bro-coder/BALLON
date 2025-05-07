extends Enemy

const BULLET = preload("res://scenes/enemys/enemybullet.tscn")



func _physics_process(delta: float) -> void:
	if died:
		return
	#rotation = lerp_angle(rotation,atan2(global_position.y - player.global_position.y,global_position.x - player.global_position.x),0.5)
	velocity = (global_position - player.global_position).normalized() * -3000 * delta 
	velocity -= knockback
	knockback = Vector2.ZERO
	
	apply_soft_collision(delta)
	move_and_slide()


func damage(pos):
	print_debug(pos)
	if !audio.playing:
		audio.pitch_scale = randf_range(0.9,1.10)
		audio.play()
		playit = true

	health -= 1
	if health <= 0:
		Global.score += scoreAdd
		shoot(0)
		shoot(3)
		#shoot(2)
		#shoot(3)
		
		die.emit(name)
		#$Area2D.queue_free()
		hide()
		await audio.finished
		queue_free()
	apply_knockback(pos,500)
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
		
func shoot(dir):
	var bullet = BULLET.instantiate()
	bullet.speed = 300
	bullet.dir = dir * 90
	bullet.global_position = global_position + Vector2(dir,dir) * 9
	bullet.global_rotation = dir * 90
	$"../../".add_child.call_deferred(bullet)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		apply_soft_collision(1)
	#if body == player:
		
		#body.damage()
		#queue_free()
	pass # Replace with function body.
