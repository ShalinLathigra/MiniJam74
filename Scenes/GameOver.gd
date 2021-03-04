extends Control

func _input(event):
	if (event is InputEventKey):
		if event.scancode == KEY_P and event.is_pressed():
			get_tree().change_scene("res://Scenes/MainMenu.tscn")
		if event.scancode == KEY_X and event.is_pressed():
			get_tree().quit()

func _ready():
	$Defeated.text = "You defeated: %s monsters" % Globals.total_defeated
	$Lasted.text = "You lasted: %s seconds" % Globals.time_alive
