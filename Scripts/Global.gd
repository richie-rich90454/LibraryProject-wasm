extends Node

signal interaction_started(action_text: String)
signal interaction_progress(ratio: float)
signal interaction_finished()
signal task_completed(world_pos: Vector2)
signal score_changed(new_score: int)

const TASK_POINTS := 10

var player_node: CharacterBody2D = null
var score: int = 0
var quiz_correct: int = 0
var quiz_attempts: int = 0
var pending_rules: Array[String] = []
var quiz_active: bool = false
var rules_shown: Dictionary = {}
var scored_tasks: Dictionary = {}

var LR: int = 0
var UD: int = 0
var lvl1done: int = 0
var lvl2done: int = 0
var lvl3done: int = 0
var givenText: String = ""
var Objectives: String = ""
var events_done: int = 0
var events_total: int = 0
var player_has_backpack: bool = false
var player_has_book: bool = false
var is_interacting: bool = false
var level_transitioning: bool = false

var sanitize_done: int = 0
var sanitize_total: int = 10
var cubby_done: int = 0
var cubby_total: int = 5
var fighting_done: int = 0
var fighting_total: int = 1
var enter_done: int = 0
var enter_total: int = 1

var books_done: int = 0
var books_total: int = 5
var shouting_done: int = 0
var shouting_total: int = 3
var running_done: int = 0
var running_total: int = 3
var food_done: int = 0
var food_total: int = 4

var checkout_done: int = 0
var checkout_total: int = 0
var chairs_done: int = 0
var chairs_total: int = 0
var leave_done: int = 0
var leave_total: int = 0
var lineup_done: int = 0
var lineup_total: int = 0

var objectives_done: Array = [false, false, false, false]
var objectives_revealed: Array = [true, true, false, false]


func start_new_game() -> void:
	level_transitioning = false
	is_interacting = false
	player_has_backpack = false
	player_has_book = false
	lvl1done = 0
	lvl2done = 0
	lvl3done = 0
	rules_shown.clear()
	scored_tasks.clear()
	pending_rules.clear()
	quiz_active = false
	quiz_correct = 0
	quiz_attempts = 0
	_set_score(0)


func award_task(task: Node, kind: String) -> void:
	var task_id: String = get_tree().current_scene.scene_file_path + "::" + str(task.get_path()) + "::" + kind
	if scored_tasks.has(task_id):
		return
	scored_tasks[task_id] = true
	_set_score(score + TASK_POINTS)


func request_rule(key: String) -> void:
	if rules_shown.get(key, false) or pending_rules.has(key):
		return
	pending_rules.append(key)


func take_next_rule() -> String:
	if pending_rules.is_empty():
		return ""
	var key: String = pending_rules.pop_front()
	rules_shown[key] = true
	quiz_active = true
	return key


func finish_quiz(attempts: int) -> void:
	quiz_correct += 1
	quiz_attempts += attempts
	var quiz_points: int = maxi(5, 25 - attempts * 5)
	_set_score(score + quiz_points)
	quiz_active = false


func has_pending_quiz() -> bool:
	return quiz_active or not pending_rules.is_empty()


func _set_score(value: int) -> void:
	score = maxi(value, 0)
	score_changed.emit(score)
