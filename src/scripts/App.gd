extends Control

const Objet = preload("res://src/scenes/Object.tscn")

onready var ObjectList = $Objects/VBoxContainer/MarginContainer3/MarginContainer2/ScrollContainer/ObjectList
onready var AddObjectDialog = $AddObjectDialog
onready var GenerationSettingsDialog = $GenerationSettings
onready var MaxWeightDialog = $MaxBagWeightDialog
onready var GenerationNumberSpin = $Objects/VBoxContainer/MarginContainer2/HBoxContainer/GenerationNumber
onready var ObjectsNumberLabel = $Objects/VBoxContainer/MarginContainer/HBoxContainer/ObjetsNumber
onready var BagObjectList = $Bag/VBoxContainer/TextureRect/MarginContainer/ColorRect/ScrollContainer/BagObjectList
onready var BagCurrentWeight = $Bag/VBoxContainer/MarginContainer/HBoxContainer/BagCurrentWeight
onready var BagMaxWeightLabel = $Bag/VBoxContainer/MarginContainer/HBoxContainer/MaxBagWeight
onready var Indicator = $Bag/VBoxContainer/MarginContainer/HBoxContainer/MarginContainer/Indicator
onready var TotalGainLabes = $Bag/VBoxContainer/MarginContainer3/HBoxContainer/TotalGain

var object_count = 1
var objects_number = 0

var bag_max_weight = 100
var bag_current_weight = 0
var bag_total_gain = 0


func fill_bag():
	#var objects = []
	var n = ObjectList.get_child_count()
	var objects = get_bag_items_without_opt(n, bag_max_weight)
	#print(get_items_without_opt(ObjectList.get_child_count(), bag_max_weight, objects))
	#print(get_items_without_opt(ObjectList.get_child_count(), bag_max_weight))
	for o in objects:
		if o != null:
			add_to_bag(o)

#recursive solution without optimisation
func get_bag_items_without_opt(i, w):
	if i == 0 or w == 0:
		return []
	var object = ObjectList.get_children()[i-1]
	var weight = object.weight
	var gain = object.gain
	if weight > w:
		return get_bag_items_without_opt(i-1, w)
	var s1 = get_bag_items_without_opt(i-1, w)
	var s2 = get_bag_items_without_opt(i-1, w - weight)
	var l = [object]
	for o in s2:
		l.append(o)
	if value(s1) > (value(s2) + gain):
		return s1
	else:
		return l

func get_items_without_opt(i, w, objects):
	if i == 0 or w == 0:
		objects = []
		return 0
	elif ObjectList.get_children()[i-1].weight > w:
		get_items_without_opt(i-1, w, objects)
	else:
		var object = ObjectList.get_children()[i-1]
		var weight = object.weight
		var gain = object.gain
		if objects == null:
			objects = []
		var s1 = get_items_without_opt(i-1, w, objects)
		var s2 = get_items_without_opt(i-1, w - weight, objects)
		if s2 == null:
			s2 = 0
		if s1 == null:
			s1 = 0
		if s1 < (s2 + gain) and not objects.has(object):
			objects.append(object)
		#else :
		#	objects.remove(objects.find(object))
		return max(s1, s2 + gain)

#func get_items_without_opt(i, w):
#	if i == 0 or w == 0:
#		return 0
#	elif ObjectList.get_children()[i-1].weight > w:
#		get_items_without_opt(i-1, w)
#	else:
#		var weight = ObjectList.get_children()[i-1].weight
#		var gain = ObjectList.get_children()[i-1].gain
#		var s1 = get_items_without_opt(i-1, w)
#		var s2 = get_items_without_opt(i-1, w - weight)
#		if s2 == null:
#			s2 = 0
#		if s1 == null:
#			s1 = 0
#		return max(s1, s2 + gain)

func value(object_list) -> int:
	if object_list == null:
		return 0
	var somme = 0
	for o in object_list:
		somme += o.gain
	return somme

func add_object(objectName, weight, gain):
	var object = Objet.instance()
	object.id = object_count
	object.object_name = objectName
	object.weight = weight
	object.gain = gain
	object.connect("put_in_bag", self, "add_to_bag")
	object.connect("remove_from_bag", self, "remove_from_bag")
	object.connect("delete", self, "delete")
	ObjectList.add_child(object)
	object_count += 1
	objects_number += 1
	ObjectsNumberLabel.text = "(" + String(objects_number) + ")"

func delete_object(object) :
	if object.in_bag :
		for child in BagObjectList.get_children() :
			if child.id == object.id :
				remove_from_bag(child)
				break
	
	object.queue_free()
	objects_number -= 1
	ObjectsNumberLabel.text = "(" + String(objects_number) + ")"
	

func add_to_bag(object) :
	var newObject = object.duplicate()
	newObject.connect("put_in_bag", self, "add_to_bag")
	newObject.connect("remove_from_bag", self, "remove_from_bag")
	newObject.connect("delete", self, "delete")
	BagObjectList.add_child(newObject)
	
	bag_current_weight += object.weight
	update_weight()
	
	bag_total_gain += object.gain
	update_gain()

func remove_from_bag(object) :
	for child in BagObjectList.get_children() :
		if child.id == object.id :
			child.queue_free()
			break
	
	for child in ObjectList.get_children() :
		if child.id == object.id :
			child.in_bag = object.in_bag
			child.disconnect("remove_from_bag", self, "remove_from_bag")
			child.refresh_bag()
			child.connect("remove_from_bag", self, "remove_from_bag")
			break
	
	bag_current_weight -= object.weight
	update_weight()
	
	bag_total_gain -= object.gain
	update_gain()

func delete(object) :
	for child in ObjectList.get_children() :
		if child.id == object.id :
			delete_object(child)
			break

func update_weight() :
	BagCurrentWeight.text = String(bag_current_weight)
	
	if bag_current_weight > bag_max_weight :
		BagCurrentWeight.set("custom_colors/font_color", Color.red)
		Indicator.start()
	else :
		BagCurrentWeight.set("custom_colors/font_color", Color.black)
		Indicator.stop()

func update_max_weight() :
	BagMaxWeightLabel.text = String(bag_max_weight)

func update_gain() :
	TotalGainLabes.text = String(bag_total_gain)

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


func _on_EmptyBag_pressed():
	for child in BagObjectList.get_children() :
		child.queue_free()
	
	for child in ObjectList.get_children() :
		child.in_bag = false
		child.refresh_bag()
	
	bag_current_weight = 0
	update_weight()
	
	bag_total_gain = 0
	update_gain()


func _on_MaxBagWeight_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT :
		MaxWeightDialog.popup_centered()


func _on_MaxBagWeightDialog_confirmed():
	bag_max_weight = MaxWeightDialog.get_max_weight()
	update_max_weight()


func _on_FillButton_pressed():
	_on_EmptyBag_pressed()
	fill_bag()
