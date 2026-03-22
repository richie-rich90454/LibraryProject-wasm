extends Node

@onready var pause_menu = $"UIFolders/options_menu.tscn" # Reference to your PauseMenu node
#I HATE MY LIFEEE
func _ready():
	# Hide the pause menu initially
	#pause_menu.hide()
	# Ensure the game starts unpaused
	get_tree().paused = false
	# Set mouse mode to captured for gameplay
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event.is_action_pressed("ui_pause"):
		toggle_pause()

func toggle_pause():
	# Toggle the paused state of the entire scene tree
	get_tree().paused = not get_tree().paused
	
	# Show/hide the pause menu accordingly
	if get_tree().paused:
		#pause_menu.show()
		# Make the cursor visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pause_menu.hide()
		# Hide the cursor and capture it for gameplay
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
