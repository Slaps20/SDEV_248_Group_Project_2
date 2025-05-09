extends Area2D

signal disable_camera
signal next_scene

func _on_area_entered(area: Area2D) -> void:
	if area == Global.playerCollision:
		$AnimatedSprite2D.play()
		set_deferred("monitoring", false)
		disable_camera.emit()
		await get_tree().create_timer(3).timeout
		next_scene.emit()
