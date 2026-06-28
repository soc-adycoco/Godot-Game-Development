extends CharacterBody2D

const GRAVITY = 3000
const JUMP_VELOCITY = -1200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += GRAVITY * delta

	# Handle jump - holding down jump key makes player continuously jump
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
