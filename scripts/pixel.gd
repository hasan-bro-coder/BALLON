extends StaticBody2D


var left: StaticBody2D

const SCREEN_SIZE := Vector2(1280, 720)
const GRID_SIZE := Vector2(1280/5, 720/5)
const PIXEL_SIZE := Vector2i(5,5)  # Size of each pixel in screen coords

@onready var pixel: Node2D = $"../../pixelmesh"
@onready var pixels: Node2D = $"pixels"
@onready var col: CollisionShape2D = $CollisionPolygon2D

var movement = false
#
#@onready var line: Line2D = $Line2D
##@onready var col: CollisionShape2D = $CollisionShape2D
##@onready var col: CollisionPolygon2D = $CollisionPolygon2D
#
#var connect: Node2D
#
var oldpos: Array[Vector2] = [Vector2(0,0),Vector2(0,0),Vector2(0,0)]

var velocity := Vector2.ZERO

func get_perpendicular_point(a: Vector2, b: Vector2, distance: float) -> Array[Vector2]:
	var ba = a - b
	var ba_normalized = ba.normalized()

	# Rotate 90 degrees clockwise or counterclockwise
	var perp1 = ba_normalized.rotated(deg_to_rad(90)) * distance
	var perp2 = ba_normalized.rotated(deg_to_rad(-90)) * distance

	var c1 = b + perp1
	var c2 = b + perp2

	# Return one of the two possible solutions
	return [c1,c2] # or c2, depending on which direction you want

func diff(x: Vector2,y: Vector2,amount: float) -> bool:
	var diffx = x.x - y.x
	var diffy = x.y - y.y
	return (diffx < amount && diffx > -amount) && (diffy < amount && diffy > -amount)
		

#func _physics_process(delta: float) -> void:
var default = global_position
var next_pos := global_position
var turn = true

var frames = 10


func _ready():
	default = global_position
	next_pos = global_position
	

func _physics_process(delta: float) -> void:
	#if !move:
		#return
	if !left:
		return
	frames += 1
	if frames > 1+randi_range(1,3):
		update()
		frames = 0
		if next_pos == global_position and movement:
			if turn:
				next_pos = get_perpendicular_point(left.global_position,global_position,randi_range(-10,10))[1]
			elif !turn:
				next_pos = default
			turn = !turn
		
		#return
	#if c == Vector2.INF:
		#c = get_perpendicular_point(left.global_position,global_position,10)[1]
		##default
	velocity = (next_pos-global_position).normalized() * 10
	global_position = lerp(global_position,global_position+velocity,delta*2)
	if diff(next_pos,global_position,0.05):
		global_position = next_pos
	#move_and_slide()
func move_to(pos):
	default = pos
	next_pos = pos

func update():
	if left && (global_position != oldpos[0] || left.global_position != oldpos[1]):
		for n in pixels.get_children():
			n.queue_free() 
		var shape = SegmentShape2D.new()
		shape.a = global_position - global_position
		 #global_position
		shape.b =  left.global_position - global_position 
		shape.custom_solver_bias = 1.0
		col.set_shape(shape)
		draw_lines(global_position,left.global_position)

		#var pol = []
		#line.clear_points()
		#var a = global_position-global_position
		#var b = left.global_position-global_position
		##pol.append(a)
		##pol.append(b)
		##pol.append(get_perpendicular_point(a,b,10)[0])
		##pol.append(get_perpendicular_point(b,a,10)[0])
		#line.add_point(global_position)
		#line.add_point(connect.global_position)
		#col.global_position = global_position
		#col.set_polygon(pol)
	oldpos = [global_position,left.global_position]
	
#func push():
	#if !left:
		#return
	#velocity = ((get_perpendicular_point(left.global_position,global_position,randi_range(-10,10))[1])-global_position).normalized() * 100
	#global_position = lerp(global_position,global_position+velocity,1)
	##next_pos = get_perpendicular_point(left.global_position,global_position,randi_range(-10,10))[1]
	#
		
func make_shape():
	if left:
		var shape := SegmentShape2D.new()
		shape.a = global_position - global_position
		 #global_position
		shape.b =  global_position - left.global_position
		shape.custom_solver_bias = 1.0
		col.set_shape(shape)
		draw_lines(global_position,left.global_position)
		
	#if connect:
		#c = get_perpendicular_point(connect.global_position,global_position,10)[1]
		#var t: MeshInstance2D = $pixel.duplicate()
		#t.top_level = true
		#t.global_position = c
		#add_child(t)
	#if connect:
		#col.polygon.clear()
		#var pol = []
		#line.clear_points()
		#var a = global_position-global_position
		#var b = connect.global_position-global_position
		##pol.append(a)
		##pol.append(b)
		##pol.append(get_perpendicular_point(a,b,10)[0])
		##pol.append(get_perpendicular_point(b,a,10)[0])
		#
		##pol.append(connect.global_position+Vector2(0,10))
		##pol.append(global_position+Vector2(0,10))
		#
		#line.add_point(global_position)
		#line.add_point(connect.global_position)
		#col.global_position = global_position
		##col.shape.a = global_position
		#var shape = SegmentShape2D.new()
		#shape.a = global_position - global_position
		
		#col.shape.b = connect.global_position
	
		#col.shape.a = global_position-global_position
		
		#shape.b = connect.global_position - global_position 
		
		#col.set_shape(shape)
		
		#col.set_polygon(pol)
		
		oldpos = [global_position,left.global_position]
		default = global_position



func draw_pixel(grid_pos: Vector2i):
	#if not pixel_scene:
		#return
	
	var instance = pixel.duplicate()
	var pixel_pos = Vector2(grid_pos.x * PIXEL_SIZE.x, grid_pos.y * PIXEL_SIZE.y)
	instance.global_position = pixel_pos
	pixels.add_child(instance)

func draw_lines(start: Vector2i, end: Vector2i):
		var poses = draw_bresenham_line(start,end)
		for pos in poses:
			draw_pixel(pos)
		
	

func draw_bresenham_line(start: Vector2i, end: Vector2i) -> Array[Vector2i]:
	var pixeld: Array[Vector2i] = []
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
		pixeld.append(Vector2i(x0, y0))
		if x0 == x1 and y0 == y1:
			break
		var e2 = 2 * err
		if e2 > -dy:
			err -= dy
			x0 += sx
		if e2 < dx:
			err += dx
			y0 += sy
	return pixeld
