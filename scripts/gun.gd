extends Sprite2D

@export var bullet_scene : PackedScene
@onready var gun = $muzzle

func _physics_process(delta):
	shoot()

func shoot():
	if Input.is_action_just_pressed("left_click"):
		var bullet = bullet_scene.instantiate()
		bullet.position = gun.global_position
		bullet.rotation = gun.global_rotation
		
		var direction = Vector2.RIGHT.rotated(gun.global_rotation)
		bullet.direction = direction
		
		get_tree().root.add_child(bullet)
