extends Node2D

var ground_obstacle_scene = preload("res://Scenes/ground_obstacle.tscn")
var flying_obstacle_scene = preload("res://Scenes/flying_obstacle.tscn")
var obstacles : Array = [ground_obstacle_scene, flying_obstacle_scene]

#Variables and constants
var speed = 0
const START_SPEED = 8
var screen_size
var score
var game_running : bool

const FLYING_Y = 355
const GROUND_Y = 515

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	$GameOverMenu.get_node("RestartButton").pressed.connect(new_game)
	new_game()

func new_game():
	score = 0
	show_score()
	game_running = false
	
	#Show start message and hide game over screen
	$HUD.get_node("StartLabel").show()
	$GameOverMenu.hide()

func _on_obstacle_spawn_timer_timeout() -> void:
	spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		speed = START_SPEED
		
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
	if game_running:
		var chosen_obstacle = obstacles.pick_random()
		var obstacle_node = chosen_obstacle.instantiate()
		var spawn_x = $Camera.position.x + 1240
		if chosen_obstacle == flying_obstacle_scene:
			obstacle_node.position = Vector2i(spawn_x, FLYING_Y)
		else:
			obstacle_node.position = Vector2i(spawn_x, GROUND_Y)
		obstacle_node.body_entered.connect(hit_obstacle)
		add_child(obstacle_node)

func hit_obstacle(body):
	if body.name == "Player":
		game_over()

func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score)

func game_over():
	get_tree().paused = true
	game_running = false
	$GameOverMenu.show()
