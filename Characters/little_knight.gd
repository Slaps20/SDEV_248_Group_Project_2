extends RigidBody2D

signal hp_changed
signal stamina_changed

@export var acceleration:float = 25.0
@export var jump_accel:float = -100.0
@onready var _animated_sprite = $AnimatedSprite2D

@onready var max_hp: int = 10
@onready var damage_taken: int = 1
@onready var hp
	
@onready var max_stamina: int = 10
@onready var stamina_used: int = 0
@onready var stamina

@onready var is_moving: bool = false
@onready var can_take_damage: bool = true
@onready var dead: bool = false

func _ready() -> void:
	Global.playerDamageZone = $DealDamage
	Global.playerCollision = $TakeDamage
	Global.get_potion.connect(consume_potion)
	Global.get_armor.connect(consume_armor)
	stamina = max_stamina
	hp = max_hp
	$CPUParticles2D.emitting = false

func _physics_process(delta: float) -> void:
	var timer = Timer.new() # probably won't need this
	timer.wait_time = 3.0
	add_child(timer)
	
	hp_changed.emit(hp, max_hp)
	
	if linear_velocity == Vector2(0, 0):
		is_moving = false
	
	if !is_moving: # idk if this makes movement better or not but whatever lol
		apply_central_impulse(Vector2.ZERO)
	
	if !dead:
		_animated_sprite.play("Idle")
		animate_stamina(delta)
		movement()
	
	
	if linear_velocity.x > 420.0 or linear_velocity.x < -420.0: # dash threshold
		$DealDamage/AttackHitbox.disabled = false
		$ResetPowerMode.start()
		$CPUParticles2D.emitting = true
		$CPUParticles2D.show()
	if $ResetPowerMode.is_stopped(): # ensures dash isn't unfairly gone while moving on ground
		$DealDamage/AttackHitbox.disabled = true
		$CPUParticles2D.emitting = false
		$CPUParticles2D.restart()
		$CPUParticles2D.hide()
			
	if $".".position.y > 1000:
		hp = 1
		take_damage()
	
	if hp <= 0 and dead:
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file.bind("res://Characters/dead.tscn").call_deferred()

func movement():
	if Input.is_action_pressed("Right"):
		is_moving = true
		_animated_sprite.play("Walk_Right_Neutral")
		if linear_velocity > Vector2(500.0, INF): # maximum velocity
			linear_velocity.x = 500.0
		else:
			apply_central_impulse(Vector2(acceleration, 0.5))
	
	if Input.is_action_pressed("Left"):
		is_moving = true
		_animated_sprite.play("Walk_Left_Neutral")
		if linear_velocity < Vector2(-500.0, INF): # maximum velocityy
			linear_velocity.x = -500.0
		else:
			apply_central_impulse((Vector2(-acceleration, 0.5)))
	
	if Input.is_action_just_pressed("Up"): # jump!
		is_moving = true
		if stamina >= 5:
			apply_central_impulse(Vector2(0, jump_accel))
			stamina -= 5

func animate_stamina(delta): # gradually recover stamina
	if stamina >= max_stamina:
		stamina = max_stamina
	else:
		stamina += 2.4 * delta
	stamina_changed.emit(stamina, max_stamina)

#func inventory():
	#var items_found = {};
	#var armor_equiped = {};
	#var weapons_equiped = {};
	#var rings = {}

func _on_take_damage_area_entered(area: Area2D) -> void:
	if can_take_damage:
		var hurtbox = $TakeDamage.get_overlapping_areas()
		if hurtbox:
			var hitbox = hurtbox.front()
			if hitbox.get_parent() is Enemy:
				take_damage()

func take_damage():
	if hp > 0:
		hp -= 3
		hp_changed.emit(hp, max_hp)
		if hp <= 0: # comically falls off map like goblin death
			hp = 0
			dead = true
			$AnimatedSprite2D.stop()
			$TakeDamage/Hurtbox.set_deferred("disabled", true)
			$DealDamage/AttackHitbox.set_deferred("disabled", true)
			set_collision_layer_value(1, false)
			set_collision_mask_value(1, false)
		can_take_damage = false # invulnerability state
		$".".modulate.a = 0.5
		await get_tree().create_timer(2).timeout
		can_take_damage = true
		$".".modulate.a = 1

func consume_potion(score, recover):
	if hp >= max_hp:
		Global.score += score
	else:
		hp += recover
		if hp > max_hp:
			hp = max_hp

func consume_armor(score, recover):
	if max_hp < 20:
		max_hp += recover
		Global.score += score / 5
	else:
		max_hp = 20
		Global.score += score
	hp += recover
	if hp > max_hp:
		hp = max_hp

func _on_area_2d_disable_camera() -> void: # connected from chest's disable_camera signal
	$Camera2D.enabled = false
