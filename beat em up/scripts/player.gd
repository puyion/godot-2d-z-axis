extends KinematicBody2D

var max_speed = 200
var acceleration = 500
var jump_speed = 25
var gravity = 5

var motion = Vector2()

var z = 0

var jumpMultiplyer = 8
var jumping = false

func _physics_process(delta):
	var axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		if jumping == false:
			$AnimationPlayer.play("idle")
		apply_friction(acceleration * delta)
	else:
		if jumping == false:
			$AnimationPlayer.play("walk")
		apply_movement(axis * acceleration * delta)
	
	if global_position.y < 250 and jumping == false:
		motion.y = 0
		if axis.y > 0:
			apply_movement(axis * acceleration * delta)
	
	if Input.is_action_just_pressed("jump") and jumping == false:
		jumping = true
		z += -jump_speed * jumpMultiplyer
	
	if z >= jump_speed * jumpMultiplyer - gravity:
		jumping = false
		z = 0
		motion.y = 0
	
	if jumping == true:
		z += gravity
		motion.y = z
	
	$CollisionShape2D.disabled = jumping
	z_index = int(jumping)
	motion = move_and_slide(motion)

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) * 2
	
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func apply_movement(accel):
	motion += accel
	motion = motion.limit_length(max_speed)
	
	$Sprite.flip_h = accel.x > 0

#const acceleration = 700
#const max_speed = 250
#const friction = 1000
#
#var velocity = Vector2.ZERO
#
#onready var animationplayer = $AnimationPlayer
#onready var image = $Sprite
#
#func _physics_process(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
#
#	if input_vector != Vector2.ZERO:
#		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
#		animationplayer.play("walk")
#
#	else:
#		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
#		animationplayer.play("idle")
#
#	if input_vector.x > 0:
#		image.flip_h = true
#	elif input_vector.x < 0:
#		image.flip_h = false
#
#	velocity = move_and_slide(velocity)
