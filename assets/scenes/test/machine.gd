extends Factory_Tile

func _process(delta):
	for all in get_overlapping_bodies():
		if all is Factory_Object:
			if all.what == "":
				all.what = "FUCK!"
				all.modulate = Color.RED
