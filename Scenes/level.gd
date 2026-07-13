extends Node2D

var speed
const START_SPEED = 8.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = START_SPEED
	
	$Player.position.x += speed
	$Camera.position.x += speed
