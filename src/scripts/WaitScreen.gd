extends ColorRect

func show():
	$AnimationPlayer.play("Show")

func hide():
	$AnimationPlayer.play_backwards("Show")
