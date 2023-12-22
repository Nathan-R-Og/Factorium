extends RigidBody2D
class_name Factory_Object
var what = ""
var mover = null
func _process(delta):
	if mover != null:
		if !mover in $Object.get_overlapping_areas():
			mover = null
	else:
		linear_velocity = lerp(linear_velocity, Vector2.ZERO, .2)
	linear_velocity = linear_velocity.limit_length(70)
