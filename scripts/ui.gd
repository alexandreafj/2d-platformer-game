extends CanvasLayer

class_name user_interface

@onready var points_label = %PointsLabel

@export var hearts: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_ui():
	points_label.text = "Points: " + str(GlobalData.points)
	for h in 3:
		if h < GlobalData.lives:
			hearts[h].show()
		else:
			hearts[h].hide()
