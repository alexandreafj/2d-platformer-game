extends RigidBody2D

@onready var game_manager = %GameManager

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x

		if(y_delta > 20):
			queue_free()
			body.jump()
		else:
			print("Decrease Player health")
			game_manager.decrease_health()
			if(x_delta > 0):
				body.jump_side(500)
			else:
				body.jump_side(-500)
