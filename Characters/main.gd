extends Node2D

func _ready() -> void:
	set_camera_limits()

func set_camera_limits(): # self explanatory...
	var map_size = $Structure.get_used_rect()
	var cell_size = $Structure.tile_set.tile_size
	$Knight/little_knight/Camera2D.limit_left = (map_size.position.x) * cell_size.x
	$Knight/little_knight/Camera2D.limit_right = (map_size.end.x) * cell_size.x
	$Knight/little_knight/Camera2D.limit_bottom = (map_size.end.y) * cell_size.y
