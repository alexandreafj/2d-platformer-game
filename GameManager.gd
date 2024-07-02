extends Node
@onready var ui = %UI

func add_point():
	GlobalData.points += 1
	ui.update_ui()

func decrease_health():
	GlobalData.lives -= 1
	ui.update_ui()
	if GlobalData.lives == 0:
		# Game over logic here
		GlobalData.points = 0
		GlobalData.lives = 3
		get_tree().reload_current_scene()
