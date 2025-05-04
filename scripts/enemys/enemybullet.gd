extends Bullet




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "bullet":
		queue_free()
	elif body.name == "player":
		body.damage()
		queue_free()
	elif !body.is_in_group("enemy") and body != self:
		print(body.name)
		queue_free()
	pass # Replace with function body.
