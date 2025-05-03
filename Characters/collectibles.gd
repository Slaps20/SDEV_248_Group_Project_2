extends Area2D # allows all collectibles to hover

class_name Collectibles

var score = 100

func _ready():
	hover()

func hover():
	var bump_tween = get_tree().create_tween()
	bump_tween.bind_node(self) # this prevents the error spam for some reason
	bump_tween.set_loops()
	bump_tween.tween_property(self, "position", position + Vector2(0, -5), 0.9)
	bump_tween.chain().tween_property(self, "position", position + Vector2(0, 5), 0.9)
