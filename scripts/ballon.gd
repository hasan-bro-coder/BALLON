extends Node2D

@onready var pixel = $pixel
@onready var ballons: Node2D = $ballons

#@onready var line: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
var positions := []
var points: Array[CharacterBody2D] = []

var center := Vector2(640, 360)
var radius := 200
var count := 30
func _ready() -> void:
	build()
	#fill(20)
	# Create the Line2D node


	# Close the circle by connecting the last point to the first
	#line.add_point(positions[0])

	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
func fill(amount: int):
	for i in 30:
		var line: Line2D = points[i].get_child(1)
		line.default_color = Color.WHITE
	for i in amount:
		var line: Line2D = points[i].get_child(1)
		line.default_color = Color.from_rgba8(255,0,90)
func build():
	for i in ballons.get_child_count():
		ballons.get_child(i).queue_free()
	points.clear()
	positions.clear()
	for i in count:
		var angle = TAU * i / count
		var pos = center + Vector2(cos(angle), sin(angle)) * radius
		positions.append(pos)
		var m: Node2D = pixel.duplicate()
		ballons.add_child(m)
		points.append(m)
	var i = 0
	for pos in positions:
		var m = points[i]
		m.global_position = pos
		m.connect = points[i+1 if i+1 < count else 0]
		i+=1 
	collision_polygon_2d.set_polygon(positions)
		
	for point in points:
		point.make_shape()
	# Add the points to the Line2D
	#for pos in positions:
		#line.add_point(pos)


func _on_timer_timeout() -> void:
	#radius+= 1
	#build()
	pass # Replace with function body.
