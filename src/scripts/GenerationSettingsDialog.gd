extends AcceptDialog

onready var PrefixeEdit = $MarginContainer/VBoxContainer/HBoxContainer/PrefixeEdit
onready var SuffixeEdit = $MarginContainer/VBoxContainer/HBoxContainer/SuffixeEdit
onready var MinWeightSpin = $MarginContainer/VBoxContainer/HBoxContainer2/MinWeightSpin
onready var MaxWeightSpin = $MarginContainer/VBoxContainer/HBoxContainer2/MaxWeightSpin
onready var MinGainSpin = $MarginContainer/VBoxContainer/HBoxContainer3/MinGainSpin
onready var MaxGainSpin = $MarginContainer/VBoxContainer/HBoxContainer3/MaxGainSpin

func get_prefixe() -> String :
	return PrefixeEdit.text

func get_suffixe() -> String :
	return SuffixeEdit.text

func get_min_weight() -> int :
	return MinWeightSpin.value

func get_max_weight() -> int :
	return MaxWeightSpin.value

func get_min_gain() -> int :
	return MinGainSpin.value

func get_max_gain() -> int :
	return MaxGainSpin.value

func _ready():
	pass # Replace with function body.

