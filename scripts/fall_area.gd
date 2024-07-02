# Falling.gd
extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body):
	if body is CharacterBody2D:
		game_manager.decrease_health()
		if GlobalData.lives > 0:
			# Reset player position instead of reloading the scene
			body.global_position = body.initial_position
