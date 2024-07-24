extends Area2D

@export var speed := 800
@onready var player := preload("res://scenes/player.tscn")
var travelled_distance := 0
const range := 4000
var direction := Vector2.ZERO
@export var enemy : PackedScene

func _ready():
	pass

func _physics_process(delta):
	position += direction * speed * delta
	travelled_distance += speed * delta
	if travelled_distance >= range:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		deal_damage(body)
		queue_free()

func deal_damage(body):
	if body.has_method("reduce_health"):
		body.reduce_health(5)
