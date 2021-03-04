extends Spatial

# Basically, need to spawn in enemies at some rate.
# Here is where we set + get Globals.difficulty and spawn in monsters with length == difficulty

onready var max_monsters : int = Globals.get_max_monsters()
onready var max_monster_length : int = Globals.get_max_monster_length()

var time_of_last_spawn = 0
var max_time_between_spawns = 2500
var time_between_spawns = 500

onready var count = 0
onready var defeated = 0

var bounds_x = 12
var bounds_z = 8

onready var player = find_player()

func find_player():
	for child in get_children():
		if (child.name == "Player"):
			print(child.get_path())
			return child.get_path()

func _ready():
	if (!player):
		var p = Globals.player.instance()
		add_child(p)
		player = p.get_path()
	get_node(player).connect("dead", self, "end_game")
		
onready var start_time = OS.get_ticks_msec()

func end_game():
	Globals.time_alive = float(OS.get_ticks_msec() - start_time) / 1000.0
	Globals.total_defeated = defeated + newly_defeated
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	print("Game Over!!!")

func _process(delta):
	
	if ((OS.get_ticks_msec() - time_of_last_spawn) > time_between_spawns and count < max_monsters):
		var mon = spawn_random_monster()
		mon.connect("monster_slain", self, "on_monster_slain")
		mon.connect("monster_escaped", self, "on_monster_escaped")
	

func spawn_random_monster() -> Monster:
		var mon : Monster = create_random_monster()
		$MonsterCollection.add_child(mon)
		time_between_spawns = randi() % max_time_between_spawns
		time_of_last_spawn = OS.get_ticks_msec()
		count += 1
		return mon
	
func create_random_monster() -> Monster:
	var loc : Vector3 = Vector3()
	
	if (randi() % 2 == 0):
		loc.x = randi() % (bounds_x * 2) - bounds_x
		if (randi() % 2 == 0):
			loc.z = bounds_z
		else:
			loc.z = -bounds_z
	else:
		loc.z = randi() % (bounds_z * 2) - bounds_z
		if (randi() % 2 == 0):
			loc.x = bounds_x
		else:
			loc.x = -bounds_x
	
	var monster : Monster = Globals.monster.instance()
	monster.length = randi() % Globals.levels[Globals.level].length + 1
	monster.translation = loc
	return monster
		
		
onready var newly_defeated = 0
func on_monster_slain(monster) -> void:
	print ("%s was slain!" % monster.name)
	newly_defeated += 1
	if (newly_defeated == Globals.levels[Globals.level].total):
		if (Globals.level < Globals.max_level):
			Globals.level += 1
			defeated += newly_defeated
			newly_defeated = 0
		elif (newly_defeated % Globals.levels[Globals.level].total == 0):
			clear_board()
	
func on_monster_escaped(monster) -> void:
	print ("%s got out!" % monster.name)
	count -= 1

func clear_board():
	for mon in $MonsterCollection.get_children():
		mon.die()

onready var num_clears = 5
func _input(event):
	# event based
	if (event is InputEventKey and num_clears > 0):
#		if event.scancode == segments[target_index].type:	# Swap to key_ scancodesj
#			if (event.is_pressed()):
#				segments[target_index].activate()
#				target_index += 1
#
#				if (target_index >= segments.size()):
#					for seg in segments:
#						seg.die()
#
#				emit_signal("monster_slain", self)
#
#		elif event.is_pressed():
#			for seg in segments:
#				seg.deactivate()
#			target_index = 0
		pass
