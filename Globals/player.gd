extends Node

signal stat_change
signal weapon_changed

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

func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	is_vulnerable = true
