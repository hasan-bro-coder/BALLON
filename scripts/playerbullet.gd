extends Bullet

func _ready():
	speed = 1000

	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.damage(velocity) 
	if body.name == "Enemybullet":
		body.queue_free()
	
	if body.name != "player":
		queue_free()
	pass # Replace with function body.
