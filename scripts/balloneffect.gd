extends Sprite2D


var zoom := 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(1.5-zoom/10,1.5-zoom/10)
	var c = ((10-zoom)/10)*255
	modulate = Color.from_rgba8(255,255,255,c)
	pass # Replace with function body.

var f = randi_range(0,2)
const MAX_FRAMES = 4  # total number of frames
const FRAME_TIME = 0.25  # seconds per frame (1 / 4fps)
var time_accumulator = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y -= (200 / zoom) * delta
	if global_position.y > 800:
		queue_free()
	time_accumulator += delta

	if time_accumulator >= FRAME_TIME:
		time_accumulator -= FRAME_TIME
		f = (f + 1) % MAX_FRAMES
		frame = f  # This depends on how your frames are set up+=de

	pass
