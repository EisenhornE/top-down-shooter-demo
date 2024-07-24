extends CharacterBody2D

signal dead

var playerload = load("res://scenes/player.tscn")
var player: CharacterBody2D = null
@export var move_speed := 200
@export var enemy_health := 20

func _physics_process(delta):
	movement()

func movement():
	if player:
		var player_position = player.position
		var target_position = (player_position - position).normalized()
		velocity = target_position * move_speed
		move_and_slide()
		look_at(player_position)
	else:
		pass

func reduce_health(amount):
	enemy_health -= amount
	if enemy_health <= 0:
		queue_free()
		emit_signal("dead")

