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

func _ready() -> void:
	Global.playerDamageZone = $DealDamage
	stamina = max_stamina
	hp = max_hp
	hp_changed.emit(hp, max_hp)


func _physics_process(delta: float) -> void:
	var timer = Timer.new() # probably won't need this
	timer.wait_time = 3.0
	add_child(timer)
	
	if linear_velocity == Vector2(0, 0):
		is_moving = false
	
	if !is_moving: # idk if this makes movement better or not but whatever lol
		apply_central_impulse(Vector2.ZERO)
		_animated_sprite.play("Idle")
	
	animate_stamina(delta)
	movement()
	
	if linear_velocity.x > 420.0 or linear_velocity.x < -420.0: # dash threshold
		$DealDamage/AttackHitbox.disabled = false
		$ResetPowerMode.start()
	if $ResetPowerMode.is_stopped(): # ensures dash isn't unfairly gone while moving on ground
		$DealDamage/AttackHitbox.disabled = true

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
		stamina += 2 * delta
	stamina_changed.emit(stamina, max_stamina)

#func inventory():
	#var items_found = {};
	#var armor_equiped = {};
	#var weapons_equiped = {};
	#var rings = {}
