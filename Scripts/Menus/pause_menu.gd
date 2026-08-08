extends CanvasLayer


# Codes the function of the buttons
func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume()


# Brings the user back to the title screen
func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/title_screen.tscn")
