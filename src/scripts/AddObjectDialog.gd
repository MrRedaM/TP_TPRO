extends AcceptDialog

onready var objectNameEdit = $MarginContainer/VBoxContainer/HBoxContainer/ObjectName
onready var weightSpin = $MarginContainer/VBoxContainer/HBoxContainer2/Weight
onready var gainSpin = $MarginContainer/VBoxContainer/HBoxContainer3/Gain

func _ready():
	pass # Replace with function body.

func get_object_name() -> String :
	return objectNameEdit.text

func get_weight() -> int :
	return weightSpin.value

func get_gain() -> int :
	return gainSpin.value
