extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.showRules == 1:
		await get_tree().create_timer(0.2).timeout
		Global.showRules = 0
		self.visible = true
		get_tree().paused = true
		await get_tree().create_timer(2).timeout
		get_tree().paused = false
		self.visible = false
	
		
