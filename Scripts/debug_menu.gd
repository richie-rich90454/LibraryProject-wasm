extends Panel

var _finishing_level := false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBox/FinishLevel.pressed.connect(_finish_level)
	$VBox/Level1.pressed.connect(_go_to_level.bind(1))
	$VBox/Level2.pressed.connect(_go_to_level.bind(2))
	$VBox/Level3.pressed.connect(_go_to_level.bind(3))
	$VBox/Close.pressed.connect(_close)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.physical_keycode == KEY_QUOTELEFT:
		if Global.quiz_active:
			return
		if visible:
			_close()
		else:
			_open()
		get_viewport().set_input_as_handled()


func _open() -> void:
	visible = true
	get_tree().paused = true
	$VBox/FinishLevel.grab_focus()


func _close() -> void:
	visible = false
	get_tree().paused = false


func _go_to_level(level: int) -> void:
	if level >= 2:
		Global.lvl1done = 1
	if level >= 3:
		Global.lvl2done = 1
	_close()
	get_tree().change_scene_to_packed(load("res://Scenes/level%d.tscn" % level))


func _finish_level() -> void:
	if _finishing_level:
		return
	_finishing_level = true
	for key in ["food", "sanitize", "books", "backpack", "fighting", "noise", "running", "chairs", "checkout", "lineup", "leave"]:
		Global.rules_shown[key] = true
	Global.pending_rules.clear()
	Global.quiz_active = false
	Global.is_interacting = false
	_close()

	# Some tasks unlock other tasks, so make several passes and allow the
	# level controller to update between them.
	for pass_index in 40:
		var completed_any := false
		for task in get_tree().get_nodes_in_group("interactables"):
			if is_instance_valid(task) and task.has_method("is_available") and task.is_available():
				completed_any = true
				_force_complete(task)
		if not completed_any:
			break
		await get_tree().process_frame
	_finishing_level = false


func _force_complete(task: Node) -> void:
	if task.has_method("start_pickup"):
		task.start_pickup()
	elif task.has_method("start_stow"):
		task.start_stow()
	elif task.has_method("start_interaction"):
		task.start_interaction()

	if task.has_method("_complete_pickup"):
		task._complete_pickup()
	elif task.has_method("_complete_stow"):
		task._complete_stow()
	elif task.has_method("_complete_interaction"):
		task._complete_interaction()
