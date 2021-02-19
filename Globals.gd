extends Node


var types = ["A", "X", "B", "P", "8"]
var difficulty : int = 1		# Length of each monster
var space = "Space"

var debug = true

const segment = preload ("res://Scenes/Components/Monsters/Segment.tscn")

func random_type() -> String : 
	return types[randi() % types.size()]
