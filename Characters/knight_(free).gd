extends CharacterBody2D

signal switch_camera
signal roll_demo

var walk_speed = 100
var gravity = 900
var stop = false
var rotate = false

func _physics_process(delta: float) -> void:
	if !stop:
		velocity.y += gravity * delta
		movement()
		
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("walk")
	
	if position.x > 270:
		switch_camera.emit()
	
	if rotate:
		crazy_rotate(delta)
	
	move_and_slide()

func movement():
	velocity.x = 0
	if Input.is_action_pressed("Right"):
		velocity.x += walk_speed
		$AnimatedSprite2D.flip_h = true
	
	if Input.is_action_pressed("Left"):
		velocity.x -= walk_speed
		$AnimatedSprite2D.flip_h = false


func _on_beginning_stop_player() -> void: #crappy cutscene
	stop = true
	$AnimatedSprite2D.stop()
	velocity.x = 0
	await get_tree().create_timer(1.0).timeout
	velocity.x += 20
	$AnimatedSprite2D.play("walk")
	await get_tree().create_timer(1.0).timeout
	$AnimatedSprite2D.stop()
	velocity.x -= 200
	await get_tree().create_timer(0.05).timeout
	velocity.x = 0
	await  get_tree().create_timer(3.07).timeout
	$CollisionShape2D.disabled = true
	velocity.y -= 800
	velocity.x -= 800
	rotate = true

func crazy_rotate(delta):
	$AnimatedSprite2D.rotation += 1000 * delta
