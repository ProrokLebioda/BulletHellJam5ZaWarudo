extends Node

signal stat_change
signal weapon_changed(weapon : WeaponBase)
signal special_state_change(is_ready : bool)

var ram_damage : int = 3
var killed_bosses : int = 0
var player_score : int = 0:
	get:
		return player_score
	set(value):
		player_score = value
		stat_change.emit()

var player_pos : Vector2
var player_invu_time : float = 0.3
var special_ready : bool = true:
	get:
		return special_ready
	set(value):
		special_ready = value
		special_state_change.emit(special_ready)

# Peculiar to keep it here, but it is used to simulate movement, even though Player doesn't actually move
var scroll_speed : float = 0.05

var is_vulnerable: bool = true
var health_base: int = 10
var health = health_base:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if is_vulnerable:
				is_vulnerable = false
				player_invulnerable_timer()
				health = value
		stat_change.emit()

var curren_weapon_type : Weapons.WeaponType = Weapons.WeaponType.SINGLE
var current_weapon_projectile_type : Weapons.ProjectileType = Weapons.ProjectileType.BASIC

var current_projectile : PackedScene:
	get:
		if !current_projectile:
			current_projectile = Weapons.get_projectile_scene(current_weapon_projectile_type)
		return current_projectile
	set(new_projectile):
		current_projectile = new_projectile
		current_weapon.projectile_scene = new_projectile

var current_weapon : WeaponBase:
	get:
		if !current_weapon:
			current_weapon = Weapons.get_weapon(curren_weapon_type)
		return current_weapon
	set(new_weapon):
		if new_weapon:
			new_weapon.projectile_scene = current_projectile
		current_weapon = new_weapon
		weapon_changed.emit(new_weapon)


func player_invulnerable_timer():
	await get_tree().create_timer(player_invu_time).timeout
	is_vulnerable = true
	
func reset_player_stats():
	special_ready = true
	health = health_base
	is_vulnerable = true
	player_score = 0
	killed_bosses = 0
	curren_weapon_type = Weapons.WeaponType.SINGLE
	current_weapon_projectile_type =  Weapons.ProjectileType.BASIC
	current_projectile = Weapons.get_projectile_scene(current_weapon_projectile_type)
	current_weapon = null
