extends Area2D
class_name Obstacle

#@export var spawnpoint = Vector2.ZERO
var speed = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed

#func get_spawn_point():
	#return spawnpoint
