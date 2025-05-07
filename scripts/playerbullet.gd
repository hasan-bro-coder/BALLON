extends Bullet

func _ready():
	speed = 1000

	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		$CPUParticles2D.color = Color.from_rgba8(255,0,90)
		$CPUParticles2D.emitting = true
		body.damage(velocity) 
	#if body.name == "Enemybullet":
		#$CPUParticles2D.emitting = true
		#body.queue_free()
	#if body.name == "pixel":
		#body.push()
	if body.name != "player":
		$CPUParticles2D.emitting = true
		$Sprite2D.hide()
		$Area2D.queue_free()
		#$Area2D.monitoring = false
		await $CPUParticles2D.finished
		queue_free()
	pass # Replace with function body.
