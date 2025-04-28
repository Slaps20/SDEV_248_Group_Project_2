extends Camera2D

func _process(delta: float) -> void:
	var knight_pos = %"little_knight".position

	self.position = knight_pos
