extends CharacterBody2D

# Constants
const GRAVITY = 3500
const JUMP_VELOCITY = -1200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += GRAVITY * delta

	# Handle jump. Holding down jump key makes player continuously jump
	if is_on_floor():
		$RunCollision.disabled = false
		if Input.is_action_pressed("Jump"):
			velocity.y = JUMP_VELOCITY
			$JumpSFX.play()
		elif Input.is_action_pressed("Duck"):
			$PlayerImage.play("duck")
			$RunCollision.disabled = true
			# Stops the duck sfx from looping
			if not $DuckSFX.is_playing():
				$DuckSFX.play()
		else:
			$PlayerImage.play("run")
	else:
		$PlayerImage.play("fly")
		
	move_and_slide()
