extends Area2D
# The flying obstacle inherits the same controls
class_name Obstacle

var speed = 8.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.x -= speed

# Removes the spawned obstacles once they exit the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
