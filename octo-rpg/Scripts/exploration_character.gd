extends CharacterBody3D

@export var speed := 5.0
@export var interact_cooldown := 1.0

@onready var ray = $RayCast3D

var can_interact := true

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
	if Input.is_action_just_pressed("interact"):
		interact()
	
	input_dir = input_dir.normalized()
	velocity.x = input_dir.x * speed
	velocity.z = input_dir.z * speed
	
	move_and_slide()

func interact() -> void:
	if not can_interact:
		return  # ainda em cooldown

	if ray.is_colliding():
		var obj = ray.get_collider()
		if obj.has_method("interact"):
			obj.interact()

	# inicia o cooldown de forma assíncrona
	can_interact = false
	await get_tree().create_timer(interact_cooldown).timeout
	can_interact = true
