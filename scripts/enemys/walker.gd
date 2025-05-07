extends Enemy

func _physics_process(delta: float) -> void:
	if died:
		return
	rotation = lerp_angle(rotation,atan2(global_position.y - player.global_position.y,global_position.x - player.global_position.x),0.5)
	velocity = (global_position - player.global_position).normalized() * -3000 * delta 
	velocity -= knockback
	knockback = Vector2.ZERO
	
	apply_soft_collision(delta)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if died:
		return
	if body.is_in_group("enemy"):
		apply_soft_collision(1)
	#if body == player:
		
		#body.damage()
		#queue_free()
	pass # Replace with function body.
