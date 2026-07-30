extends Node2D

var ground_obstacle_scene = preload("res://Scenes/ground_obstacle.tscn")
var flying_obstacle_scene = preload("res://Scenes/flying_obstacle.tscn")
var obstacles = [ground_obstacle_scene, flying_obstacle_scene]

#Variables and constants
var speed = 0
const START_SPEED = 8
var screen_size
var score = 0
var game_running : bool

var player_original_pos
var camera_original_pos
var ground_original_pos

var flying_height = [400, 300]
const GROUND_Y = 515

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	player_original_pos = $Player.position
	camera_original_pos = $Camera.position
	ground_original_pos = $Ground.position
	
	$GameOverMenu.get_node("RestartButton").pressed.connect(new_game)
	#$PauseMenu.get_node("VBoxContainer/Restart").pressed.connect(new_game)

func new_game():
	score = 0
	show_score()
	game_running = false
	get_tree().paused = false
	get_tree().call_group("delete_obstacles", "queue_free")
	
	$Player.position = player_original_pos
	$Camera.position = camera_original_pos
	$Ground.position = ground_original_pos
	
	#Show start message and hide game over screen
	$HUD.get_node("StartLabel").show()
	$GameOverMenu.hide()
	$PauseMenu.hide()

func _on_obstacle_spawn_timer_timeout() -> void:
	spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
		var spawn_count = randi_range(1, 2)
		
		for i in range(spawn_count):
			var chosen_obstacle = obstacles.pick_random()
			var obstacle_node = chosen_obstacle.instantiate()
			var current_spawn_x = $Camera.position.x + 1240 + (i * 100)
			if chosen_obstacle == flying_obstacle_scene:
				var flying_y = flying_height.pick_random()
				obstacle_node.position = Vector2i(current_spawn_x, flying_y)
			else:
				obstacle_node.position = Vector2i(current_spawn_x, GROUND_Y)
			obstacle_node.body_entered.connect(hit_obstacle)
			obstacle_node.add_to_group("delete_obstacles")
			add_child(obstacle_node)
			current_spawn_x += randi_range(300, 350)

func hit_obstacle(body):
	if body.name == "Player":
		game_over()

func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score / 10)

func game_over():
	$Player/HitSFX.play()
	get_tree().paused = true
	game_running = false
	$GameOverMenu.show()
