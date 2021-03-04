extends Control

func _input(event):
	if (event is InputEventKey):
		if event.scancode == KEY_P and event.is_pressed():
			get_tree().change_scene("res://Scenes/Level.tscn")
		if event.scancode == KEY_X and event.is_pressed():
			get_tree().quit()
