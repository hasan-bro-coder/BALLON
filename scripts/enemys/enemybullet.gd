extends Bullet

var frame = 0
const MAX_FRAMES = 4  # total number of frames
const FRAME_TIME = 0.25  # seconds per frame (1 / 4fps)
var time_accumulator = 0.0

func _process(delta):
	time_accumulator += delta

	if time_accumulator >= FRAME_TIME:
		time_accumulator -= FRAME_TIME
		frame = (frame + 1) % MAX_FRAMES
		$Sprite2D.frame = frame  # This depends on how your frames are set up+=de

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		#dir += 30*randi_range(-1,1)
		return
		#$CPUParticles2D.emitting = true
		#$Sprite2D.hide()
		#await $CPUParticles2D.finished
		#queue_free()
	if body.name == "player":
		body.damage()
	if body.is_in_group("enemy") || body.name == "Enemybullet" || body.name == "bullet":
		return
	$CPUParticles2D.emitting = true
	$Sprite2D.hide()
	await $CPUParticles2D.finished
	queue_free()
	pass # Replace with function body.
