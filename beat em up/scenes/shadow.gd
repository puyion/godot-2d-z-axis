extends Sprite

func _process(_delta):
	if get_parent().get_node("KinematicBody2D").jumping == false:
		global_position = get_parent().get_node("KinematicBody2D").global_position
	else:
		global_position.x = get_parent().get_node("KinematicBody2D").global_position.x


