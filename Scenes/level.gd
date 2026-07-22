extends Node2D

#Variables and constants
var speed
const START_SPEED = 8.0
var screensize
var score = 0
var game_running : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_window().size
	new_game()
	
func new_game():
	score = 0
	show_score()
	game_running = false
	
	$HUD.get_node("StartLabel").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		speed = START_SPEED
		
		$Player.position.x += speed
		$Camera.position.x += speed
		
		score += speed
		show_score()
		
		if $Camera.position.x - $Ground.position.x > screensize.x * 1.5:
			$Ground.position.x += screensize.x
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score)
