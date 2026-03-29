extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(self.linear_velocity != Vector2(0,0)):
		await get_tree().create_timer(0.1).timeout
		self.linear_velocity -= Vector2(0.1,0.1)
		self.linear_velocity = Vector2(max(0, self.linear_velocity.x),max(0, self.linear_velocity.y))
		
