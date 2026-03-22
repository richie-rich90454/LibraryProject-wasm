extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.UD == -1):
		Global.UD = 0
	if(self.button_pressed):
		Global.UD = -1
	
