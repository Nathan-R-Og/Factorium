extends Node2D


@export var going = "right"
var b = Path2D

var moving = true
var there = false
@export var speed = 500
var path = PackedVector2Array()
var git = path
var pathbank = []
var lengthWaste = 320.0
var amount = true


var GLOBALdelta = 0.0017

var choose = false
var choosing = false



func _ready():
	genDir()

func genDir():
	var s = Vector2(32,32)
	var pos1 = Vector2()
	var pos2 = Vector2()
	match going:
		"right":
			pos1 = global_position
			pos2 = global_position + Vector2(s.x, 0)
		"up":
			pos1 = global_position
			pos2 = global_position - Vector2(0, s.y)
		"left":
			pos1 = global_position
			pos2 = global_position - Vector2(s.x, 0)
		"down":
			pos1 = global_position
			pos2 = global_position + Vector2(0, s.y)
	path = PackedVector2Array([pos1,pos2])



func _process(delta):
	if moving == true:
		there = false
		var move_distance = speed * delta
		move_along_path(move_distance)
	print(pathbank)


func move_along_path(distance):
	var start_point = global_position
	for i in range(path.size()):
		if lengthWaste > 0.0 or amount == false:
			var distance_to_next = start_point.distance_to(path[0])
			if distance <= distance_to_next and distance >= 0.0:
				lengthWaste -= 1
				global_position = (start_point.lerp(path[0], distance / distance_to_next))
				break
			elif distance < 0.0:
				global_position = path[0]
				moving = false
				there = true
				break
			distance -= distance_to_next
			start_point = path[0]
			path.remove_at(0)
			if path.size() == 0:
				moving = false
				there = true
				break
		elif (lengthWaste <= 0 and amount == true):
			when()
	if path.size() == 0 and moving == false:
		when()

func when():
	moving = false
	if pathbank.size() == 0:
		genDir()
		moving = true
		amount = true
		lengthWaste = 320.0
	elif pathbank.size() >= 1 and choose == true:
		pass
		#STOP
	elif pathbank.size() >= 1 and choose == false:
		path = pathbank.pop_front()
		moving = true
		amount = false


func set_path(value):
	path = value
	if value.size() == 0:
		return
	moving = true



func _on_touchy_area_entered(area):
	var g = area.get_parent()
	g.swinga(self, going)
