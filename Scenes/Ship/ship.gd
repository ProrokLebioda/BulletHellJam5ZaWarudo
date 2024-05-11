extends CharacterBody2D


# Shooting
var can_shoot : bool = true
@export var weapon_cooldown: float = 0.5 
@onready var weapon_cooldown_timer = $WeaponCooldownTimer

# weapon mounts

signal shoot(position)

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	position = mouse_pos
	
	if Input.get_action_strength("fire") and can_shoot:
		print("fire")
		can_shoot = false
		weapon_cooldown_timer.start(weapon_cooldown)
		shoot.emit(global_position)

func _on_weapon_cooldown_timer_timeout():
	can_shoot = true
