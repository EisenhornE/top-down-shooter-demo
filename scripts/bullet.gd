extends Area2D

@export var speed := 800
@onready var player := preload("res://scenes/player.tscn")
var travelled_distance := 0
const range := 4000
var direction := Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance >= range:
		queue_free()

func _on_body_entered(body):
	queue_free()
