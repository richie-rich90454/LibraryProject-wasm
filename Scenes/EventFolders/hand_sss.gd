extends "res://Scripts/hand_ss.gd"

# Phase designations set per-instance in level1.tscn
@export var is_fighter: bool = false

var phase: String = "sanitize"
@onready var fight_cloud: Sprite2D = $FightCloud

func _ready() -> void:
	super._ready()
	add_to_group("kids")
	interaction_text = "Cleaning hands..."

func _update_phase() -> void:
	if phase == "clean":
		if is_fighter and Global.fighting_done == 0 and Global.sanitize_done >= Global.sanitize_total:
			phase = "fighting"
			Global.objectives_revealed[2] = true

func _process(delta: float) -> void:
	_update_phase()

	if phase == "fighting":
		interaction_text = "Stopping the fight..."
		fight_cloud.visible = true
		animated_sprite.visible = false
		var pulse := sin(Time.get_ticks_msec() * 0.012)
		fight_cloud.rotation = pulse * 0.08
		fight_cloud.scale = Vector2.ONE * (0.78 + pulse * 0.04)
	else:
		interaction_text = "Cleaning hands..."
		fight_cloud.visible = false
		animated_sprite.visible = true

	# Forward walk animation whenever the student moves (any direction)
	if animated_sprite and not is_walking_away:
		if self.linear_velocity.length() > 5.0:
			if animated_sprite.animation != "Walk":
				animated_sprite.play("Walk")
		elif animated_sprite.animation == "Walk":
			animated_sprite.play("Idle")

	super._process(delta)

func can_interact() -> bool:
	return done == 0 and (phase == "sanitize" or phase == "fighting")

func marker_visible() -> bool:
	return can_interact() and not Global.player_has_backpack

func start_walking() -> void:
	done = 1
	is_walking_away = true
	freeze = true
	if has_node("ObjectMarker"):
		$ObjectMarker.visible = false
	# Walk forward (left) toward the library entrance
	if animated_sprite:
		animated_sprite.play("Walk")
	var target = global_position + Vector2(-320, 0)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target, 2.2).set_ease(Tween.EASE_IN_OUT)

func _complete_interaction() -> void:
	is_organizing = false
	interaction_elapsed = 0.0
	Global.is_interacting = false
	Global.interaction_finished.emit()
	Global.task_completed.emit(global_position)

	if phase == "sanitize":
		Global.request_rule("sanitize")
		Global.sanitize_done += 1
		Global.events_done += 1
		Global.award_task(self, "sanitize")
		phase = "clean"
		if Global.sanitize_done >= Global.sanitize_total:
			Global.objectives_done[0] = true

	elif phase == "fighting":
		Global.request_rule("fighting")
		Global.fighting_done += 1
		Global.events_done += 1
		Global.award_task(self, "fight")
		Global.objectives_done[2] = true
		phase = "clean"
		fight_cloud.visible = false
		animated_sprite.visible = true

	if animated_sprite:
		animated_sprite.animation = "Idle"
