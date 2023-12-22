extends Node2D


@export var way = [[null, "up"]]
@export var img = ""


func _ready():
	$AnimatedSprite.play(img)

func swinga(player, currway):
	var ifMult = []
	var m = 0
	while m < way.size():
		if way[m][0] == null or way[m][0] == currway:
			ifMult.append(way[m])
		m += 1
	var ext = 0
	while ext < ifMult.size():
		var newpath = PackedVector2Array()
		var pos1 = get_node("enterDir").get_node(currway).global_position
		var pos2 = get_node("exitDir").get_node(ifMult[ext][1]).global_position
		newpath = PackedVector2Array([pos1, pos2])
		ext += 1
		player.going = ifMult[0][1]
		player.pathbank.append(newpath)
