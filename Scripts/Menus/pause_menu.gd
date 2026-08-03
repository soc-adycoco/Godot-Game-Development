extends CanvasLayer

# Codes the function of the buttons
func pause():
	get_tree().paused = true

func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	pass

#$HUD.get_node("PauseButton").pressed.connect(pause)


# Brings the user back to the title screen
func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/title_screen.tscn")
