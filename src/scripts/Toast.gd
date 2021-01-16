extends MarginContainer

export var show_time : int = 5

var showing = false

func show_message(message):
	visible = true
	showing = true
	$Panel/Label.text = message
	$AnimationPlayer.play("Show")
	$Timer.start(show_time)


func hide():
	$AnimationPlayer.play_backwards("Show")


func _on_Timer_timeout():
	showing = false
	hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	if not showing:
		visible = false
