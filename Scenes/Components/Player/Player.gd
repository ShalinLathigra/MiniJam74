extends CSGSphere

onready var hp = 10.0

signal dead ()

func _on_Area_area_entered(area):
	area.die(false)
	hp -= 1
	if (hp <= 0):
		emit_signal("dead")

export (float) var change_rate = 0.125

func _process(delta):
	material.albedo_color.r = 5.0 + 15.0 * (hp / 10.0)
