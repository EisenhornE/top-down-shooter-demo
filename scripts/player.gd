extends CharacterBody2D

@export var speed = 400
@onready var gun = $gun
@export var player_health := 100
@export var damage_interval := 1
@onready var damage_Timer = $damage_timer

var enemies_in_hitbox = []

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

func _on_hitbox_area_body_entered(body):
	if body is CharacterBody2D and body.name == "enemy":
		enemies_in_hitbox.append(body)
		player_health -= 10
		if player_health <= 0:
			queue_free()
		if damage_Timer.is_stopped():
			damage_Timer.start()

func _on_hitbox_area_body_exited(body):
	if body is CharacterBody2D and body.name == "enemy":
		enemies_in_hitbox.erase(body)
		if enemies_in_hitbox.is_empty():
			damage_Timer.stop()

func _on_damage_timer_timeout():
	for enemy in enemies_in_hitbox:
		player_health -= 5
		if player_health <= 0:
			queue_free()
			get_tree().quit()
			break
