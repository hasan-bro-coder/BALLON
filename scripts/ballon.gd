extends Node2D

@onready var pixel = $pixel
@onready var ballons: Node2D = $ballons

#@onready var line: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
# Set this to your pixel mesh (e.g., a QuadMesh in a MeshInstance2D scene)
@export var pixel_scene: PackedScene

const SCREEN_SIZE := Vector2(1280, 720)
const GRID_SIZE := Vector2(1280/5, 720/5)
const PIXEL_SIZE := Vector2i(5,5)  # Size of each pixel in screen coords

# Called when the node enters the scene tree for the first time.
var positions := []
var points: Array[StaticBody2D] = []

var center := Vector2(640, 360)
var radius := 200
var count := 20
func _ready() -> void:
	#build()
	
	#draw_bresenham_line(Vector2i(10, 10), Vector2i(200, 100))
	
	#fill(20)
	# Create the Line2D node


	# Close the circle by connecting the last point to the first
	#line.add_point(positions[0])

	pass # Replace with function body.

var pixel_data: Dictionary[Vector2,Array] = {
	
}
var pixel_line: Dictionary[Vector2,Array] = {
	
}

## Called every frame. 'delta' is the elapsed time since the previous frame.
var frame = 0
func _physics_process(delta: float) -> void:
	#frame+=1
	#if frame >= 120:
		#for i in ballons.get_child_count():
			#ballons.get_child(i).queue_free()
		#var i = 0
		#positions[i] += Vector2(1,1)
		##update_pixel(positions[i])
		##for pos in positions:
			##draw_bresenham_line((pos / PIXEL_SIZE).floor(),(positions[i+1 if i+1 < count else 0] / PIXEL_SIZE).floor())
			##i+=1
		#frame = 0
	pass
	
#func update_pixel(pos: Vector2):
	#var connect = pixel_data[pos]
	#for i in pixel_line[pos]:
		#i.queue_free()
	#for i in pixel_line[connect[0]]:
		#i.queue_free()
	#
	#draw_bresenham_line(connect[0],pos)
	#draw_bresenham_line(pos,connect[1])
	#
	
func fill(amount: int):
	if points.is_empty():
		return
	if amount == 0:
		for i in count-1:
			var line: Node2D = points[i].get_child(1)
			line.modulate = Color.WHITE
	for i in amount-1:
		var line: Node2D = points[i].get_child(1)
		line.modulate = Color.from_rgba8(255,0,90)
	pass

func expand():
	positions.clear()
	for i in count:
		var angle = TAU * i / count
		var pos = center + Vector2(cos(angle), sin(angle)) * radius
		points[i].move_to(pos)
		positions.append(pos)
	#collision_polygon_2d.set_polygon(positions)
	
	

func build():
	if !positions.is_empty():
		expand()
		return
	for i in ballons.get_child_count():
		ballons.get_child(i).queue_free()
	points.clear()
	positions.clear()
	for i in count:
		var angle = TAU * i / count
		var pos = center + Vector2(cos(angle), sin(angle)) * radius
		positions.append(pos)
		var m: Node2D = pixel.duplicate()
		m.global_position = pos
		m.movement = true if \
		i % 2 == 0 \
		#i == 0 || i == 5 || i == 10 || i == 15 
		else false
		points.append(m)
		
		
		
	var i = 0
	#for pos in positions:
		#draw_bresenham_line(pos,positions[i+1 if i+1 < count else 0])
		#i+=1
		
		
	for m in points:
		#pixel_data[pos] = [positions[i-1 if i-1 >= 0 else count-1],positions[i+1 if i+1 < count else 0]]
		m.left = points[i+1 if i+1 < count else 0]
		ballons.add_child(m)
		m.make_shape()
		i+=1
		
	#var i = 0
	#for pos in positions:
		#var m = points[i]
		#m.global_position = pos
		
		#i+=1 
	#collision_polygon_2d.set_polygon(positions)
		
	#for point in points:
		#point.make_shape()
	# Add the points to the Line2D
	#for pos in positions:
		#line.add_point(pos)

func draw_pixel(grid_pos: Vector2i,pos: Vector2):
	#if not pixel_scene:
		#return
	
	var instance = pixel.duplicate()
	var pixel_pos = Vector2(grid_pos.x * PIXEL_SIZE.x, grid_pos.y * PIXEL_SIZE.y)
	instance.global_position = pixel_pos
	ballons.add_child(instance)
	#pixel_line[pos].append(instance)

func draw_bresenham_line(start: Vector2i, end: Vector2i):
	start = (start / PIXEL_SIZE)
	end = (end / PIXEL_SIZE)
	
	var x0 = start.x
	var y0 = start.y
	var x1 = end.x
	var y1 = end.y

	var dx = abs(x1 - x0)
	var dy = abs(y1 - y0)

	var sx = 1 if x0 < x1 else -1
	var sy = 1 if y0 < y1 else -1

	var err = dx - dy

	while true:
		draw_pixel(Vector2i(x0, y0),start)
		if x0 == x1 and y0 == y1:
			break
		var e2 = 2 * err
		if e2 > -dy:
			err -= dy
			x0 += sx
		if e2 < dx:
			err += dx
			y0 += sy


func _on_timer_timeout() -> void:
	#radius+= 1
	#build()
	pass # Replace with function body.
