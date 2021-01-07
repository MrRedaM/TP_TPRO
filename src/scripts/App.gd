extends Control

const Objet = preload("res://src/scenes/Object.tscn")

onready var ObjectList = $Objects/VBoxContainer/MarginContainer3/MarginContainer2/ScrollContainer/ObjectList
onready var AddObjectDialog = $AddObjectDialog
onready var GenerationSettingsDialog = $GenerationSettings
onready var GenerationNumberSpin = $Objects/VBoxContainer/MarginContainer2/HBoxContainer/GenerationNumber
onready var ObjectsNumberLabel = $Objects/VBoxContainer/MarginContainer/HBoxContainer/ObjetsNumber
onready var BagObjectList = $Bag/VBoxContainer/TextureRect/MarginContainer/ColorRect/ScrollContainer/BagObjectList

var object_count = 1
var objects_number = 0

func add_object(objectName, weight, gain):
	var object = Objet.instance()
	object.id = object_count
	object.object_name = objectName
	object.weight = weight
	object.gain = gain
	object.connect("put_in_bag", self, "add_to_bag")
	object.connect("remove_from_bag", self, "remove_from_bag")
	ObjectList.add_child(object)
	object_count += 1
	objects_number += 1
	ObjectsNumberLabel.text = "(" + String(objects_number) + ")"

func delete_object(object) :
	object.queue_free()
	objects_number -= 1
	ObjectsNumberLabel.text = "(" + String(objects_number) + ")"

func add_to_bag(object) :
	var newObject = object.duplicate()
	newObject.connect("put_in_bag", self, "add_to_bag")
	newObject.connect("remove_from_bag", self, "remove_from_bag")
	BagObjectList.add_child(newObject)

func remove_from_bag(object) :
	for child in BagObjectList.get_children() :
		if child.id == object.id :
			child.queue_free()
			break
	
	for child in ObjectList.get_children() :
		if child.id == object.id :
			child.in_bag = object.in_bag
			child.refresh_bag()
			break

func _ready():
	pass


func _on_AddObjectButton_pressed():
	AddObjectDialog.popup_centered()


func _on_GenerationSettingsButton_pressed():
	GenerationSettingsDialog.popup_centered()


func _on_AddObjectDialog_confirmed():
	add_object(AddObjectDialog.get_object_name(), 
	AddObjectDialog.get_weight(), 
	AddObjectDialog.get_gain())


func _on_GenerateButton_pressed():
	var prefixe = GenerationSettingsDialog.get_prefixe()
	var suffixe = GenerationSettingsDialog.get_suffixe()
	var min_weight = GenerationSettingsDialog.get_min_weight()
	var max_weight = GenerationSettingsDialog.get_max_weight()
	var min_gain = GenerationSettingsDialog.get_min_gain()
	var max_gain = GenerationSettingsDialog.get_max_gain()
	var generation_number = GenerationNumberSpin.value
	
	for i in range(generation_number) :
		var object_name = prefixe + String(object_count) + suffixe
		var weight = rand_range(min_weight, max_weight)
		var gain = rand_range(min_gain, max_gain)
		
		add_object(object_name, weight, gain)
	
	GenerationNumberSpin.value = 1


func _on_DeleteAllButton_pressed():
	for child in ObjectList.get_children() :
		delete_object(child)
	object_count = 1
