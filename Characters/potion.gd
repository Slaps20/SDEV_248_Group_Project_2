extends Collectibles

func _ready() -> void:
	hover()
	score = 500

func _on_area_entered(area: Area2D) -> void:
	if area == Global.playerCollision:
		Global.get_potion.emit(score, recover) # see little_knight's _ready
		queue_free()
