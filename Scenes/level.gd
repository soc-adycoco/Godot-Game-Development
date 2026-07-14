extends Node2D

#Variables and constants
var speed
const START_SPEED = 8.0
var screensize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screensize = get_window().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	speed = START_SPEED
	
	$Player.position.x += speed
	$Camera.position.x += speed
	
	if $Camera.position.x - $Ground.position.x > screensize.x:
		$Ground.position.x += screensize.x
