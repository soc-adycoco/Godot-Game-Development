extends CanvasLayer

#@onready var hud_pause

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	hud_pause = $HUD.get_node("PauseButton").pressed.connect(pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
#	pass # Replace with function body.


# Codes the function of the buttons
func pause():
	if get_tree().paused == false:
		get_tree().paused = true
		visible = true
	elif get_tree().paused == true:
		get_tree().paused = false
		visible = false

func resume():
	get_tree().paused = false
	visible = false

func _on_resume_pressed() -> void:
	resume()


# Brings the user back to the title screen
func _on_home_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/Menus/title_screen.tscn")
