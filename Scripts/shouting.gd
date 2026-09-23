extends "res://Scripts/hand_ss.gd"

func _ready() -> void:
	super._ready()
	interaction_text = "Using a quiet voice..."

func firsttime():
	Global.request_rule("noise")
	Global.events_done += 1
	Global.shouting_done += 1
	if Global.shouting_done >= Global.shouting_total:
		Global.objectives_done[1] = true
