extends CharacterBody2D

func _physics_process(delta: float) -> void:
	$EnemyImage.play("enemy_fly")
