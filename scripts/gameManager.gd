extends Node2D

@export var enemy_scene : PackedScene
@onready var player = $"../player"
@onready var spawnTimer = $spawn_timer
@onready var reduce_spawnTimer = $reduce_spawn_timer
var score = 0

# PLEASE REMEMBER TO PUT COLOR RECT ABOVE EVERYTHING OR JUST DELETE IT AND USE 
# PROJECT SETTINGS -> ENVIRONMENT FOR WHITE BACKGROUND

# DO NOT USE PRELOAD. IT CORRUPTS THE SCENES DUE TO CYCLONIC REFERENCES IN GODOT
# GOD CHATGPT AND GEMINI IS FUCKING USELESS

func _ready():
	spawnTimer.wait_time = 4.0
	spawnTimer.start()
	reduce_spawnTimer.start()

func _on_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	var enemy_spawn_location = %enemy_spawn_point
	enemy_spawn_location.progress_ratio = randf()
	enemy.position = enemy_spawn_location.position
	enemy.player = player
	add_child(enemy)
	enemy.dead.connect(self.onenemydead)
	spawnTimer.start()

func _on_reduce_spawn_timer_timeout():
	spawnTimer.wait_time -= 1.0
	if spawnTimer.wait_time <= 1.0:
		reduce_spawnTimer.stop()

func onenemydead():
	score += 10
	print("Score: ", score)
	
