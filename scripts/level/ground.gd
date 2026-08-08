extends StaticBody2D

var screen_width

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_width = get_window().size


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	position.x += screen_width.x
