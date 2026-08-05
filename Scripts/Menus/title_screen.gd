extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level/level.tscn")

func _on_tutorial_button_pressed() -> void:
	$Tutorial.show()

func _on_credits_button_pressed() -> void:
	$Credits.show()
