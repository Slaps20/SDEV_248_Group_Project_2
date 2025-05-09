extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()

func move_left():
	velocity.x -= 1000

func move_right():
	velocity.x += 2000
