extends Spatial
class_name Monster

export (int, 1, 10) var length

export (float, 0.0, 2.0) var wiggle_offset_modifier = 1.0	# 15 deg * this
export (int) var min_wiggle_rate = 180
export (int) var max_wiggle_rate = 360
export (float, 0.0, 2.0) var wiggle_width_modifier = 1.0	# .32 * this
export (float, 0.0, 2.0) var offset_modifier = 1.0	# .32 * this

onready var wiggle_rate = randi() % (max_wiggle_rate - min_wiggle_rate) + min_wiggle_rate

func create_segment(i : int) -> Segment:
	var j : Segment = Globals.segment.instance()
	j.wiggle_offset = (length - i) * 15.0 * wiggle_offset_modifier
	j.wiggle_rate = float(wiggle_rate)
	j.wiggle_width = .08 + i * 0.08 * wiggle_width_modifier
	j.translate(Vector3(0,0,0.64 * offset_modifier * i))
	j.rotation_degrees = -rotation_degrees
	return j
	
func _ready():
	look_at_from_position(translation, Vector3(0,0,0), Vector3.UP)
	for i in range(length):
		var seg = create_segment(i)
		seg.type = Globals.random_type()
		add_child(seg)
		
	
	add_child(create_segment(length))
		
		
export (float, 0, 4.0) var rate = 1.0
export (float) var size = 0.64


func _physics_process(delta):
	translate(Vector3.FORWARD * rate * size * delta)
	pass
