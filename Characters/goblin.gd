extends CharacterBody2D

class_name Enemy

@onready var facing = 0 # -1/1 moves left/right; 0 doesn't move
@onready var speed = 40
@onready var dead = false
@onready var points = 150

func _ready() -> void:
	Global.enemyDamageZone = $DealDamage

func _physics_process(delta: float) -> void:
	if dead == true:
		velocity.y += 1500 * delta
	else:
		velocity.y += 500 * delta
		velocity.x = facing * speed
	
	$AnimatedSprite2D.flip_h = velocity.x > 0
	for i in get_slide_collision_count(): # just turns around when colliding a wall
		var collision = get_slide_collision(i)
		if collision.get_normal().x != 0:
			facing = sign(collision.get_normal().x)
	
	if position.y > 1000:
		queue_free()
	
	move_and_slide()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area == Global.playerDamageZone: # cartoonishly flips out of existence when killed
		dead = true
		Global.score += points
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.flip_v = true
		$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
		$DealDamage/CollisionShape2D.set_deferred("disabled", true)
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		velocity.y = -100


func _on_visible_on_screen_notifier_2d_screen_entered() -> void: # starts moving
	facing = -1
