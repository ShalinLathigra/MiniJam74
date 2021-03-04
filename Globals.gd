extends Node


var level : int = 0		# Length of each monster
var max_level : int = 5		# Length of each monster

var levels : Dictionary = {
	0 : {
		"length" : 1, 
		"count" : 3, 
		"total" : 6,
		},
	1 : {
		"length" : 2, 
		"count" : 5,
		"total" : 7,
		},
	2 : {
		"length" : 3, 
		"count" : 4,
		"total" : 9,
		},
	3 : {
		"length" : 3, 
		"count" : 5,
		"total" : 14,
		},
	4 : {
		"length" : 5, 
		"count" : 3,
		"total" : 13,
		},
	5 : {
		"length" : 5, 
		"count" : 6,
		"total" : 15,
		},
}


func get_max_monsters() -> int:
	return levels[level].count
func get_max_monster_length() -> int:
	return levels[level].length

var space = KEY_SPACE
var types = [KEY_A, KEY_X, KEY_B, KEY_P, KEY_8]
var char_frames = {
	KEY_A : preload("res://Resources/SpriteFrames/A.tres"),
	KEY_X : preload("res://Resources/SpriteFrames/X.tres"),
	KEY_B : preload("res://Resources/SpriteFrames/B.tres"),
	KEY_P : preload("res://Resources/SpriteFrames/P.tres"),
	KEY_8 : preload("res://Resources/SpriteFrames/8.tres"),
	KEY_SPACE : preload("res://Resources/SpriteFrames/Space.tres"),
}
#$Sprite.frames = Globals.char_frames[type]

var debug = true

const segment = preload ("res://Scenes/Components/Monsters/Segment.tscn")
const monster = preload ("res://Scenes/Components/Monsters/Monster.tscn")
const player = preload ("res://Scenes/Components/Player/Player.tscn")

func random_type() -> String : 
	return types[randi() % types.size()]
	
var total_defeated = 0
var time_alive = 0.0
