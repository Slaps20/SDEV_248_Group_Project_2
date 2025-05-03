extends Collectibles

func _ready() -> void:
	hover()
	score = 500

func _on_area_entered(area: Area2D) -> void:
	if area == Global.playerCollision:
		Global.score += score
		queue_free()

# tryna give hp? too bad, i can't figure it out, certainly not with global var
