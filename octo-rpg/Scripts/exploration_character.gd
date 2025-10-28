extends CharacterBody3D

@export var speed := 5.0

func _physics_process(delta):
	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("move_front"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	
	input_dir = input_dir.normalized()
	
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed
	
	move_and_slide()
