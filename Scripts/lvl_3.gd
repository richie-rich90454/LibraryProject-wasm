extends Button

# Called when the node enters the scene tree for the first time
func _ready():
	# Connect the button's pressed signal to our custom function
	pressed.connect(_on_start_pressed)

# Custom function to handle start button click
func _on_start_pressed():
		# Load and switch to the game scene (replace "res://Game.tscn" with your actual game scene path)
	if(Global.lvl2done):
		var game_scene = load("res://Scenes/level3.tscn")
		get_tree().change_scene_to_packed(game_scene)
	else:
		Global.showRules = 1
		Global.givenText = "Finish Level 1 and 2 First to Proceed to Level 3!"
