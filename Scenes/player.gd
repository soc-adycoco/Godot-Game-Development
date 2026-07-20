extends CharacterBody2D

const GRAVITY = 3000
const JUMP_VELOCITY = -1200.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity.y += GRAVITY * delta
	
	

	# Handle jump - holding down jump key makes player continuously jump
	if is_on_floor():
		#$RunCollision.disabled = false
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			$JumpSFX.play()
		elif Input.is_action_pressed("ui_down"):
			$PlayerImage.play("duck")
			$RunCollision.disabled = true
			$DuckSFX.play()
		else:
			$PlayerImage.play("run")
	else:
		$PlayerImage.play("fly")
		
	move_and_slide()
