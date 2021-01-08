extends AcceptDialog

onready var MaxWeightSpin = $HBoxContainer2/SpinBox

func get_max_weight() -> int :
	return MaxWeightSpin.value

func _ready():
	pass # Replace with function body.

