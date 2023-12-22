extends Factory_Tile
@export var direction = 1
@export var aim = 5
var gates = []
var force = 5

func _process(delta):
	doObjectMove()
	detect()
func doObjectMove():
	for all in get_overlapping_bodies():
		if all is Factory_Object and all.mover in [null, self]:
			all.linear_velocity += getcoord(aim) * direction * force
			all.mover = self

var sizer = Vector2i.ONE * 3
func getcoord(i):
	i -= floor(sizer.x / 2) + (floor(sizer.y / 2) * sizer.x)
	return Vector2(i%sizer.x, floor(i/sizer.x))
func detect():
	var Sense = ShapeCast2D.new()
	Sense.shape = RectangleShape2D.new()
	Sense.shape.size = Vector2.ONE
	Sense.collide_with_areas = true
	Sense.target_position = Vector2i.ZERO
	add_child(Sense)
	
	gates.resize(sizer.x * sizer.y)
	gates.fill(false)
	for i in sizer.x * sizer.y:
		var coord = getcoord(i)
		var soink = coord * 64
		Sense.position = soink
		Sense.force_shapecast_update()
		for x in Sense.get_collision_count():
			if Sense.get_collider(x) is Factory_Tile:
				gates[i] = true
				break
	
	remove_child(Sense)
	Sense.queue_free()
