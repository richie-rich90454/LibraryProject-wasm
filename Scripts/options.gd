extends Button

# Called when the node enters the scene tree for the first time
func _ready():
	# Connect the button's pressed signal to our custom function
	pressed.connect(_on_options_pressed)

# Custom function to handle start button click
func _on_options_pressed():
	Global.hPage = 1
