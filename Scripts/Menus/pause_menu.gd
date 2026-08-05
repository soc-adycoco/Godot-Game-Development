extends CanvasLayer

func _unhandled_input(_event: InputEvent) -> void:
	# Pauses the game if ESC key or pause button is pressed
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused



# Codes the function of the buttons
func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume()


# Brings the user back to the title screen
func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menus/title_screen.tscn")
