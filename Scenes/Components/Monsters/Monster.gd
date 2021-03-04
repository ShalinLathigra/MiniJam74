extends Spatial
class_name Monster

export (int, 1, 10) var length

export (float, 0.0, 2.0) var wiggle_offset_modifier = 1.0	# 15 deg * this
export (int) var min_wiggle_rate = 180
export (int) var max_wiggle_rate = 360
export (float, 0.0, 2.0) var wiggle_width_modifier = 1.0	# .32 * this
export (float, 0.0, 2.0) var offset_modifier = 1.0	# .32 * this

onready var wiggle_rate = randi() % (max_wiggle_rate - min_wiggle_rate) + min_wiggle_rate

onready var target_index : int = 0

var segments = []

func create_segment(i : int) -> Segment:
	var j : Segment = Globals.segment.instance()
	j.wiggle_offset = (length - i) * 15.0 * wiggle_offset_modifier
	j.wiggle_rate = float(wiggle_rate)
	j.wiggle_width = .08 + i * 0.08 * wiggle_width_modifier
	j.translate(Vector3(0,0,0.64 * offset_modifier * i))
	j.rotation_degrees = -rotation_degrees
	return j
	
func _ready():
	$Sprite3D.visible = false
	look_at_from_position(translation, Vector3(0,0,0), Vector3.UP)
	for i in range(length):
		var seg = create_segment(i)
		seg.type = Globals.random_type()
		add_child(seg)
		segments.push_back(seg)
	#var cap = create_segment(length)
	#add_child(cap)
	#segments.push_back(cap)
	rate = (6.0 - length) / 5.0 * 5.0
export (float, 0, 4.0) var rate = 1.0
export (float) var size = 0.64

signal monster_slain (obj)
signal monster_escaped (obj)

var alive = true

func _input(event):
	# event based
	if (event is InputEventKey and target_index < segments.size()):
		if event.scancode == segments[target_index].type:	# Swap to key_ scancodesj
			if (event.is_pressed()):
				segments[target_index].activate()
				target_index += 1
				
				if (target_index >= segments.size()):
					alive = false
					for seg in segments:
						seg.die()
				
				emit_signal("monster_slain", self)
				$GoodPlayer.unit_db = 5
				$GoodPlayer.play(0.0)
				
		elif event.is_pressed():
			for seg in segments:
				seg.deactivate()
			target_index = 0
		
func _physics_process(delta):
	translate(Vector3.FORWARD * rate * size * delta)
	if translation.x < -14 or translation.x > 14:
		emit_signal("monster_escaped", self)
		queue_free()
	elif translation.z < -10 or translation.z > 10:
		emit_signal("monster_escaped", self)
		queue_free()

func die(state : bool=false):
	for segment in segments:
		segment.die(state)
