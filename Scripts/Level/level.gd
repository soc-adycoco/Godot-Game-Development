extends Node2D

var ground_obstacle_scene = preload("res://Scenes/Obstacles/ground_obstacle.tscn")
var flying_obstacle_scene = preload("res://Scenes/Obstacles/flying_obstacle.tscn")
var obstacles = [ground_obstacle_scene, flying_obstacle_scene]

# Variables and constants
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
	# Set player, camera, and ground positions to current
	player_original_pos = $Player.position
	camera_original_pos = $Camera.position
	ground_original_pos = $Ground.position
	
	# Restart the game after pressing restart button
	$GameOverMenu.get_node("RestartButton").pressed.connect(new_game)
	$PauseMenu.get_node("VBoxContainer/Restart").pressed.connect(new_game)

# Reset each new game
func new_game():
	score = 0
	show_score()
	game_running = false
	get_tree().paused = false
	# Delete any obstacles already spawned
	get_tree().call_group("delete_obstacles", "queue_free")
	
	# Reset positions to original
	$Player.position = player_original_pos
	$Camera.position = camera_original_pos
	$Ground.position = ground_original_pos
	
	# Show start message and hide game over screen and pause menu
	$HUD.get_node("StartLabel").show()
	$GameOverMenu.hide()
	$PauseMenu.hide()

func _on_obstacle_spawn_timer_timeout() -> void:
	spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if game_running:
		# Set speed
		speed = START_SPEED
		
		# Move the player and camera and increase score based on the set speed
		$Player.position.x += speed
		$Camera.position.x += speed
		score += speed
		show_score()
		
		# Shift the ground to the right if the player and camera moves too far
		if $Camera.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
		
		# Pauses the game by making the pause menu visible
		if Input.is_action_just_pressed("Exit") and get_tree().paused == false:
			get_tree().paused = true
			$PauseMenu.show()
		# Close the pause menu and resume the current run
		elif Input.is_action_just_pressed("Exit") and get_tree().paused == true:
			get_tree().paused = false
			$PauseMenu.hide()
		
	else:
		# Wait for the player to press a key before the run starts
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			$HUD.get_node("StartLabel").hide()

func spawn_obstacle():
	if game_running:
		# Random amount of obstacles
		var spawn_count = randi_range(1, 2)
		
		for i in range(spawn_count):
			# Randomly spawn either the ground or flying obstacle
			var chosen_obstacle = obstacles.pick_random()
			var obstacle_node = chosen_obstacle.instantiate()
			# Spawn the obstacles to the right of the game window
			var current_spawn_x = $Camera.position.x + screen_size.x + (i * 100)
			
			if chosen_obstacle == flying_obstacle_scene:
				# Spawn the flying obstacle at one of the two heights
				var flying_y = flying_height.pick_random()
				obstacle_node.position = Vector2i(current_spawn_x, flying_y)
			else:
				obstacle_node.position = Vector2i(current_spawn_x, GROUND_Y)
			
			obstacle_node.body_entered.connect(hit_obstacle)
			# Obstacles in the group will be deleted after exiting the screen
			obstacle_node.add_to_group("delete_obstacles")
			add_child(obstacle_node)
			
			# Spawn the obstacles at different intervals from each other
			current_spawn_x += randi_range(300, 350)

# Player loses if they hit an obstacle
func hit_obstacle(body):
	if body.name == "Player":
		game_over()

# Display the modified score (not increasing as rapidly) on the game's HUD
func show_score():
	$HUD.get_node("ScoreLabel").text = "Score: " + str(score / 10)

# Player uses after they hit an obstacle
func game_over():
	$Player/HitSFX.play()
	get_tree().paused = true
	game_running = false
	$GameOverMenu.show()
