extends Node2D

func _ready() -> void:
	set_camera_limits()

func set_camera_limits(): # self explanatory...
	var map_size = $Structure.get_used_rect()
	var cell_size = $Structure.tile_set.tile_size
	$Knight/little_knight/Camera2D.limit_left = (map_size.position.x + 2) * cell_size.x
	$Knight/little_knight/Camera2D.limit_right = (map_size.end.x) * cell_size.x
	$Knight/little_knight/Camera2D.limit_bottom = (map_size.end.y - 2) * cell_size.y
	$Knight/little_knight/Camera2D.limit_top = (map_size.position.y) * cell_size.y

func _on_area_2d_next_scene() -> void: # connected from chest's next_scene signal
	get_tree().change_scene_to_file.bind("res://Characters/start.tscn").call_deferred()
