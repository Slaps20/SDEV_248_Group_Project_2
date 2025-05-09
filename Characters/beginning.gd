extends Node2D

signal stop_player
signal move_npc_left
signal move_npc_right

func _process(delta: float) -> void:
		if $NPC.position.x >= 10:
			$Chest.hide()

func _on_knight_free_switch_camera() -> void:
	$Camera2D.enabled = false


func _on_trigger_scene_body_entered(body: Node2D) -> void: # a very badly manually hardcoded cutscene
	if body is CharacterBody2D:
		stop_player.emit()
		$"Knight (Free)/Label".show()
		await get_tree().create_timer(1.0).timeout # gets approached
		$"Knight (Free)/Label".hide()
		await get_tree().create_timer(1.0).timeout # spook
		$NPC/AnimatedSprite2D.skew = rad_to_deg(0)
		$NPC/AnimatedSprite2D.rotation = 0
		$NPC/AnimatedSprite2D.play("look")
		$NPC/AnimatedSprite2D.position.y = 16
		$NPC/AnimatedSprite2D.position.x -= 10
		await get_tree().create_timer(2.05).timeout
		$NPC/AnimatedSprite2D.play("bouncee")
		await get_tree().create_timer(1).timeout
		$NPC/AnimatedSprite2D.play("look")
		move_npc_left.emit()
		await get_tree().create_timer(1.1).timeout
		move_npc_right.emit()
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file.bind("res://Characters/main.tscn").call_deferred()
