extends Control

const Objet = preload("res://src/scenes/Object.tscn")

onready var ObjectList = $Objects/VBoxContainer/MarginContainer3/MarginContainer2/ScrollContainer/ObjectList
onready var AddObjectDialog = $AddObjectDialog
onready var GenerationSettingsDialog = $GenerationSettings

func add_object():
	var object = Objet.instance()
	ObjectList.add_child(object)

func _ready():
	for i in range(10) :
		add_object()


func _on_AddObjectButton_pressed():
	AddObjectDialog.popup_centered()


func _on_GenerationSettingsButton_pressed():
	GenerationSettingsDialog.popup_centered()
