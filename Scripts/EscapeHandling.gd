extends Node2D
@onready var pause_menu = $"../CanvasLayer/Options Menu" # Reference to your PauseMenu node

func _ready() -> void:
	pause_menu.hide()
	get_tree().paused = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_pause"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	
	if get_tree().paused:
		pause_menu.show()
	else:
		pause_menu.hide()
