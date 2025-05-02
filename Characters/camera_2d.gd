extends Camera2D # we don't really need this

func _process(delta: float) -> void:
	var knight_pos = %"little_knight".position

	self.position = knight_pos
