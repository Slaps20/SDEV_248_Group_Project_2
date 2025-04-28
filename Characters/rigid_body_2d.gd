extends RigidBody2D

@export var acceleration:float = 30.0
@export var jump_accel:float = -100.0
@onready var _animated_sprite = $AnimatedSprite2D

@onready var max_hp: int = 10
@onready var damage_taken: int = 1
@onready var hp
	
@onready var max_stamina: int = 10
@onready var stamina_used: int = 0
@onready var stamina:int

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	var timer = Timer.new()
	timer.wait_time = 3.0
	add_child(timer)
	
	var rtl = $"../Camera2D/Health, Stamina, Magic"
	
	if Input.is_action_pressed("Right"):
		_animated_sprite.play("Walk_Right_Neutral")
		apply_central_impulse(Vector2(acceleration,0.5))
	elif Input.is_action_pressed("Left"):
		_animated_sprite.play("Walk_Left_Neutral")
		apply_central_impulse((Vector2(-acceleration,0.5)))
	elif Input.is_action_just_pressed("Up"):
		#_animated_sprite.play("Jump")
		apply_central_impulse(Vector2(0, jump_accel))
		stamina_used += 5;
	#elif Input.is_action_pressed("Down"):
		#_animated_sprite.play("Down")
	else:
		apply_central_impulse(Vector2.ZERO)
		_animated_sprite.play("Idle")
		timer.start(3.0)
		stamina_used = 0

	stamina = max_stamina - stamina_used
	hp = max_hp - damage_taken
	
	if stamina_used > max_stamina:
		acceleration = 5
		jump_accel = -25
	else:
			acceleration = 30
			jump_accel = -100

	var output = ""
	output += "HP: " + str(hp) + "/" + str(max_hp) + "\n"
	output += "Stamina: " + str(stamina) + "/" + str(max_stamina)
	
	rtl.text = output;


#func inventory():
	#var items_found = {};
	#var armor_equiped = {};
	#var weapons_equiped = {};
	#var rings = {}
