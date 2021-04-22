extends ColorRect

var seconds = 0
var minutes = 0

func show():
	$AnimationPlayer.play("Show")

func hide():
	$AnimationPlayer.play_backwards("Show")
	$VBoxContainer/WaitTimer/Timer.stop()

func start_timer():
	$VBoxContainer/WaitTimer/TimerMinutes.text = "00"
	$VBoxContainer/WaitTimer/TimerSeconds.text = "00"
	seconds = 0
	minutes = 0
	$VBoxContainer/WaitTimer/Timer.start()
	

func _on_Timer_timeout():
	seconds += 1
	if seconds == 60:
		minutes += 1
		seconds = 0
	$VBoxContainer/WaitTimer/TimerMinutes.text = "%02d" % minutes
	$VBoxContainer/WaitTimer/TimerSeconds.text = "%02d" % seconds
