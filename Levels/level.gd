extends Node2D

@onready var player_projectiles_node = $Projectiles/Player
@onready var enemies_projectiles_node = $Projectiles/Enemies

# Player weapon stuff
@export var current_weapon : WeaponBase
@onready var player_weapon_node = $PlayerWeapon


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	assign_player_weapon()
	Player.connect("weapon_changed", _on_weapon_changed)
	

func _on_weapon_changed(new_weapon):
	var all_weapons = player_weapon_node.get_children()
	for wp in all_weapons:
		wp.queue_free()
	assign_player_weapon()

func assign_player_weapon():
	# TODO: Change so it works with different weapon types maybe?
	var wp = Player.current_weapon as WeaponBase
	var wp_enum : Weapons.WeaponType = wp.weapon_type
	var weapon_for_player = wp
	player_weapon_node.add_child(weapon_for_player)
	current_weapon = weapon_for_player


# Callables
func _on_ship_shoot(pos):
	if current_weapon != null:
		var projectiles = current_weapon.fire(pos, Vector2.UP)
		for projectile in projectiles:
			player_projectiles_node.add_child(projectile) 
	else:
		print_verbose("No weapon")


func _on_enemy_simple_ufo_enemy_shoot(pos, dir, projectile):
	enemies_projectiles_node.add_child(projectile)
	
