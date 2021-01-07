extends TextureRect

onready var timer = $Timer

var show = false

func start() :
	timer.start()

func stop() :
	timer.stop()
	self.modulate = Color(1, 1, 1, 0)

func _ready():
	self.modulate = Color(1, 1, 1, 0)

func _on_Timer_timeout():
	if show :
		self.modulate = Color(1, 1, 1, 0)
		show = false
	else :
		self.modulate = Color(1, 1, 1, 1)
		show = true
