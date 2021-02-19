extends Area
class_name Segment
# Segments can be:
#		Active
#		Dying
#		Dead

enum STATE {
	ACTIVE,
	DYING,
	DEAD,
}

export (STATE) var state = STATE.ACTIVE

var wiggle_offset = 0
var wiggle_rate = 360.0
var wiggle_width = 0.32

var type = Globals.space

func _ready():
	if (type == Globals.space and Globals.debug):
		$Sprite.modulate = Color.rebeccapurple

func _process(delta):
	# wiggle left to right
	translation.x = cos(deg2rad(wiggle_rate * OS.get_ticks_msec() / 1000 + wiggle_offset)) * wiggle_width
	pass
