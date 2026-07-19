extends Node2D

#Variables and constants
var speed
const START_SPEED = 8.0
var screensize
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screensize = get_window().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = START_SPEED
	
	$Player.position.x += speed
	$Camera.position.x += speed
	
	score += speed
	show_score()
	
	if $Camera.position.x - $Ground.position.x > screensize.x * 1.5:
		$Ground.position.x += screensize.x

func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score)
