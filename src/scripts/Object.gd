extends Panel

export var object_name : String
export var weight : int
export var gain : int

onready var objectNameLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/ObjectName
onready var weightLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/WeightLabel
onready var gainLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/GainLabel

func _ready():
	objectNameLabel.text = String(object_name)
	weightLabel.text = String(weight)
	gainLabel.text = String(gain)
