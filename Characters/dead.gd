extends Control

func _process(delta: float) -> void:
	if Input.is_action_pressed("Up"):
		get_tree().change_scene_to_file.bind("res://Characters/main.tscn").call_deferred()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file.bind("res://Characters/main.tscn").call_deferred()
