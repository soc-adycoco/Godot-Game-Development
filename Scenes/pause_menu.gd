extends CanvasLayer

func pause():
	get_tree().paused = true

func resume():
	get_tree().paused = false
	visible = false

func Esc():
	if Input.is_action_just_pressed("Exit") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Exit") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	pass

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
