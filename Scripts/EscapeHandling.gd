extends Node2D
@onready var pause_menu = $"../CanvasLayer/Options Menu"

func _ready() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _process(_delta: float) -> void:
	if(Global.hPage == 1):
		toggle_pause()

func _unhandled_input(event):
	if event.is_action_pressed("ui_pause"):
		Global.hPage = 1

func toggle_pause():
	get_tree().paused = not get_tree().paused
	
	if get_tree().paused:
		pause_menu.show()
	else:
		pause_menu.hide()
	Global.hPage = 0
