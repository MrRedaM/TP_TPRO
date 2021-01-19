extends ColorRect

export var id : int
export var object_name : String
export var weight : int
export var gain : int
export var in_bag : bool

onready var objectNameLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/ObjectName
onready var weightLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/WeightLabel
onready var gainLabel = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/HBoxContainer/GainLabel
onready var bagButton = $MarginContainer/HBoxContainer/BagButton

signal put_in_bag(object)
signal remove_from_bag(object)
signal delete(object)

func refresh_bag() :
	bagButton.pressed = in_bag
	pass

func set_in_bag(bag):
	bagButton.pressed = bag

func _ready():
	objectNameLabel.text = String(object_name)
	weightLabel.text = String(weight)
	gainLabel.text = String(gain)
	bagButton.pressed = in_bag


func _on_BagButton_toggled(button_pressed):
	if button_pressed :
		in_bag = true
		emit_signal("put_in_bag", self)
	else :
		in_bag = false
		emit_signal("remove_from_bag", self)


func _on_DeleteButton_pressed():
	emit_signal("delete", self)
