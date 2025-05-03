extends Collectibles

func _on_area_entered(area: Area2D) -> void:
	if area == Global.playerCollision:
		Global.score += score
		queue_free()
