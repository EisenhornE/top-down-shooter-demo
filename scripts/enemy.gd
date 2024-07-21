extends CharacterBody2D

var playerload = preload("res://scenes/player.tscn")
var player: CharacterBody2D = null
@export var move_speed := 200

func _physics_process(delta):
	movement()

func movement():
	if player:
		var player_position = player.position
		var target_position = (player_position - position).normalized()
		velocity = target_position * move_speed
		move_and_slide()
	else:
		print("Player node not found")
