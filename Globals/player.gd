extends Node

signal stat_change
signal weapon_changed(weapon : WeaponBase)

var player_pos : Vector2
var player_invu_time : float = 0.3

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
var current_weapon_projectile : Weapons.ProjectileType = Weapons.ProjectileType.BASIC

var current_weapon : WeaponBase:
	get:
		if !current_weapon:
			current_weapon = Weapons.get_weapon(curren_weapon_type)
		return current_weapon
	set(new_weapon):
		current_weapon = new_weapon
		weapon_changed.emit(new_weapon)


func player_invulnerable_timer():
	await get_tree().create_timer(player_invu_time).timeout
	is_vulnerable = true
	
func reset_player_stats():
	health = health_base
	is_vulnerable = true
	current_weapon = null
