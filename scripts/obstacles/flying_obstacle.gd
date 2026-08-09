# Inherits the ground obstacle's speed variable
extends Obstacle

const MODIFY_SPEED = 2

func _physics_process(delta: float) -> void:
	$Sprite2D.play("enemy_fly")
	# Flying obstacles move faster so not overlap with ground obstacles
	position.x -= speed * MODIFY_SPEED * delta

# Removes the spawned obstacles once they exit the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
