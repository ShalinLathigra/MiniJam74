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
	$Sprite.frames = Globals.char_frames[type]
	if (type == Globals.space and Globals.debug):
		$Sprite.modulate = Color.red

func _process(delta):
	# wiggle left to right
	translation.x = cos(deg2rad(wiggle_rate * OS.get_ticks_msec() / 1000 + wiggle_offset)) * wiggle_width
	if ($Sprite.animation == "Dead"):
		$Sprite.modulate.a -= delta

func activate():
	if ($Sprite.animation != "Dead"):
		$Particles.emitting = true
		$Sprite.animation = "Highlighted"
		$Sprite.modulate = Color.orange
		collision_layer = 1
		collision_mask = 1
		

func deactivate():
	if ($Sprite.animation != "Dead"):
		$Sprite.animation = "Idle"
		$Sprite.modulate = Color.white
		collision_layer = 1
		collision_mask = 1
	
func die(friendly : bool = true):
	if ($Sprite.animation != "Dead"):
		$DeathParticles.emitting = true
		$Sprite.animation = "Dead"
		
		if (friendly):
			$Sprite.modulate = Color.green
			$Sprite.modulate *= 2.0
		else:
			$Sprite.modulate = Color.red
			$Sprite.modulate *= 2.0
			$BadPlayer.unit_db = 5
			$BadPlayer.play(0.0)

		collision_layer = 0
		collision_mask = 0
		
