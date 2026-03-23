extends CheckButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		$"../MenuBar".hide()
		$"../ColorRect".hide()
	else:
		$"../MenuBar".show()
		$"../ColorRect".show()
