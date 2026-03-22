extends HSlider

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value-5)


func _on_resolutions_item_selected(index: int) -> void:
	pass # Replace with function body.
