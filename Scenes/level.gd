extends Node2D

var ground_obstacle_scene = preload("res://Scenes/ground_obstacle.tscn")
var flying_obstacle_scene = preload("res://Scenes/flying_obstacle.tscn")
var obstacles : Array

#Variables and constants
var speed = 0
const START_SPEED = 8.0
var screen_size
var score
var ground_height : int
var game_running : bool
var last_obstacle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = 96
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
		
		spawn_obstacle()
		
		$Player.position.x += speed
		$Camera.position.x += speed
		
		score += speed
		show_score()
		
		if $Camera.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
			
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func spawn_obstacle():
	if obstacles.is_empty() or last_obstacle.position.x < score / 10 + randi_range(300, 500):
		var obstacle
		obstacle = ground_obstacle_scene.instantiate()
		var obstacle_height = 16
		var obstacle_x : int = screen_size.x + speed + 100
		var obstacle_y : int = screen_size.y - ground_height - (obstacle_height * 6  / 2) + 5
		last_obstacle = obstacle
		add_obstacle(obstacle, obstacle_x, obstacle_y)
		
func add_obstacle(obstacle, x, y):
	obstacle.position = Vector2i(x, y)
	add_child(obstacle)
	obstacles.append(obstacle)

func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score)
