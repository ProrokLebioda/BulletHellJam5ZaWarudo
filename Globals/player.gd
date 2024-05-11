extends Node

signal stat_change
signal weapon_changed(weapon : WeaponBase)

var player_pos : Vector2

var is_vulnerable: bool = true
var health_base: int = 100
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

var current_weapon : WeaponBase:
	get:
		if !current_weapon:
			current_weapon = Weapons.get_basic_weapon()
		return current_weapon
	set(new_weapon):
		current_weapon = new_weapon
		weapon_changed.emit(current_weapon)


func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	is_vulnerable = true
