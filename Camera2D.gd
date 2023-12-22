extends Camera2D


@export var playerPath = NodePath()
@onready var player = get_node(playerPath)




func _process(delta):
	position = player.position
