extends Collectibles

func _ready() -> void:
	hover()
	score = 1000

func _on_area_entered(area: Area2D) -> void:
	if area == Global.playerCollision:
		Global.get_armor.emit(score, recover) # see little_knight's _ready
		queue_free()
