extends CharacterBody2D


# Shooting
var can_shoot : bool = true
var can_special : bool = true
@export var weapon_cooldown: float = 0.2 
@export var special_cooldown : float = 2
@onready var weapon_cooldown_timer = $WeaponCooldownTimer
@onready var special_cooldown_timer = $SpecialCooldownTimer
@onready var special_weapon = $SpecialWeapon

@export var special_attack_ready_sound : AudioStream 

var disp_size : Vector2i
# weapon mounts

signal shoot(position)
signal special_attack_shot()

func _ready():
	disp_size = DisplayServer.window_get_size_with_decorations()

func _physics_process(delta):
	#disp_size = DisplayServer.window_get_size_with_decorations()
	var mouse_pos = get_global_mouse_position()
	# clamp out of bounds
	#var bounds :Vector2 = Vector2(disp_size.x /2, disp_size.y/2)
	var bounds :Vector2 = Vector2(450, disp_size.y/2)
	mouse_pos.x = clamp(mouse_pos.x, -bounds.x, bounds.x)
	mouse_pos.y = clamp(mouse_pos.y, -bounds.x, bounds.y)
	
	position = mouse_pos
	Player.player_pos = position
	if Input.get_action_strength("fire") and can_shoot:
		print("fire")
		can_shoot = false
		weapon_cooldown_timer.start(weapon_cooldown)
		shoot.emit(global_position)
	
	if Input.get_action_strength("special") and can_special:
		print("special")
		can_special = false
		special_cooldown_timer.start(special_cooldown)
		special_attack_shot.emit()
		Player.special_ready = can_special


func hit(damage:int):
	if Player.is_vulnerable:
		Player.health-=damage
		print("Player hit for ", damage, " damage!")
		AudioPlayer.play_FX(AudioPlayer.hit_sound, -10.0)
	if Player.health <= 0:
		Player.health = 0
		#queue_free()
		get_tree().change_scene_to_file("res://UI/game_over.tscn")

func _on_weapon_cooldown_timer_timeout():
	can_shoot = true

func _on_special_cooldown_timer_timeout():
	can_special = true
	Player.special_ready = can_special
	AudioPlayer.play_FX(special_attack_ready_sound, -12.0)


func _on_special_attack_shot():
	if special_weapon:
		var beam = special_weapon.fire()
		beam.position = special_weapon.position
		add_child(beam)
	else:
		print("No special")
