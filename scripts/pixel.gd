extends CharacterBody2D

@onready var line: Line2D = $Line2D
#@onready var col: CollisionShape2D = $CollisionShape2D
#@onready var col: CollisionPolygon2D = $CollisionPolygon2D

var connect: Node2D

var oldpos: Array[Vector2] = [Vector2(0,0),Vector2(0,0)]


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
@onready var default = global_position
@onready var c := Vector2.INF

var turn = true

func _physics_process(delta: float) -> void:
	if connect and c == Vector2.INF:
		c = get_perpendicular_point(connect.global_position,global_position,10)[1]
	if c == global_position and connect:
		#global_position = c
		if turn:
			c = \
			get_perpendicular_point(connect.global_position,global_position,randi_range(-5,15))[1]
		elif !turn:
			c = default
		turn = !turn
		#default
	velocity = (c-global_position).normalized() * 10
	global_position = lerp(global_position,global_position+velocity,delta)
	if diff(c,global_position,0.05):
		global_position = c
	update()
	#move_and_slide()
	
func update():
	if connect && (global_position != oldpos[0] || connect.global_position != oldpos[1]):
		var pol = []
		line.clear_points()
		var a = global_position-global_position
		var b = connect.global_position-global_position
		#pol.append(a)
		#pol.append(b)
		#pol.append(get_perpendicular_point(a,b,10)[0])
		#pol.append(get_perpendicular_point(b,a,10)[0])
		line.add_point(global_position)
		line.add_point(connect.global_position)
		#col.global_position = global_position
		#col.set_polygon(pol)
		oldpos = [global_position,connect.global_position]
		
		
func make_shape():
	
	#if connect:
		#c = get_perpendicular_point(connect.global_position,global_position,10)[1]
		#var t: MeshInstance2D = $pixel.duplicate()
		#t.top_level = true
		#t.global_position = c
		#add_child(t)
	if connect && (global_position != oldpos[0] || connect.global_position != oldpos[1]):
		#col.polygon.clear()
		var pol = []
		line.clear_points()
		var a = global_position-global_position
		var b = connect.global_position-global_position
		#pol.append(a)
		#pol.append(b)
		#pol.append(get_perpendicular_point(a,b,10)[0])
		#pol.append(get_perpendicular_point(b,a,10)[0])
		
		#pol.append(connect.global_position+Vector2(0,10))
		#pol.append(global_position+Vector2(0,10))
		
		line.add_point(global_position)
		line.add_point(connect.global_position)
		#col.global_position = global_position
		##col.shape.a = global_position
		#var shape = SegmentShape2D.new()
		#shape.a = global_position - global_position
		
		#col.shape.b = connect.global_position
	
		#col.shape.a = global_position-global_position
		
		#shape.b = connect.global_position - global_position 
		
		#col.set_shape(shape)
		
		#col.set_polygon(pol)
		
		oldpos = [global_position,connect.global_position]
	default = global_position
