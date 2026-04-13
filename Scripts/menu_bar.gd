extends MenuBar

func _process(delta: float) -> void:
	if(Global.Objectives != ""):
		var currentOBJs = FileAccess.open(Global.Objectives, FileAccess.READ)
		$"Objective 1".text = " - " + currentOBJs.get_line()
		$"Objective 2".text = " - " + currentOBJs.get_line()
		$"Objective 3".text = " - " + currentOBJs.get_line()
		if(not currentOBJs.eof_reached()):
			$"Objective 4".text = " - " + currentOBJs.get_line()
		else:
			$"Objective 4".text = ""
	else:
		print(Global.Objectives)
