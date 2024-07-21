extends CharacterBody2D

@export var speed = 400
@onready var gun = $gun

func _physics_process(delta):
	movement()
	aim()

func movement():
	#Movement
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
func aim():
	#Aim and Shoot
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
