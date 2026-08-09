extends Area2D
# The flying obstacle inherits the same speed variable
class_name Obstacle

var speed = 200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.x -= speed * delta

# Removes the spawned obstacles once they exit the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
