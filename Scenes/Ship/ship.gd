extends CharacterBody2D


# Shooting
var can_shoot : bool = true
@export var weapon_cooldown: float = 0.5 
@onready var weapon_cooldown_timer = $WeaponCooldownTimer
var disp_size : Vector2i
# weapon mounts

signal shoot(position)

func _ready():
	disp_size = DisplayServer.window_get_size_with_decorations()

func _physics_process(delta):
	#disp_size = DisplayServer.window_get_size_with_decorations()
	var mouse_pos = get_global_mouse_position()
	# clamp out of bounds
	var bounds :Vector2 = Vector2(disp_size.x /2, disp_size.y/2)
	
	mouse_pos.x = clamp(mouse_pos.x, -bounds.x, bounds.x)
	mouse_pos.y = clamp(mouse_pos.y, -bounds.x, bounds.y)
	
	position = mouse_pos
	Player.player_pos = position
	if Input.get_action_strength("fire") and can_shoot:
		print("fire")
		can_shoot = false
		weapon_cooldown_timer.start(weapon_cooldown)
		shoot.emit(global_position)

#func clamp_pos_in_bounds(pos_in : Vector2) -> Vector2:
#	if pos_in.x < disp_size.x:
#		pos_in.x = disp_size.x
#	if pos_in.x > disp_size.x:
#		pos_in.x = disp_size.x
#	if pos_in.y < disp_size.y:
#		pos_in.y = disp_size.y

func _on_weapon_cooldown_timer_timeout():
	can_shoot = true

func hit(damage:int):
	print("Player hit for ", damage, " damage!")
	
