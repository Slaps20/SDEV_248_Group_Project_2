extends Control
@onready var skip_intro = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("Up"):
		if skip_intro == true:
			get_tree().change_scene_to_file.bind("res://Characters/main.tscn").call_deferred()
		else:
			get_tree().change_scene_to_file.bind("res://Characters/beginning.tscn").call_deferred()

func _on_button_pressed() -> void:
	if skip_intro == true:
		get_tree().change_scene_to_file.bind("res://Characters/main.tscn").call_deferred()
	else:
		get_tree().change_scene_to_file.bind("res://Characters/beginning.tscn").call_deferred()

func _on_check_button_toggled(toggled_on: bool) -> void:
	if skip_intro == false:
		skip_intro = true
	else:
		skip_intro = false
