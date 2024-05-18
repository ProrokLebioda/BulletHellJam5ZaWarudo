extends Node2D

@onready var player_projectiles_node = $Projectiles/Player
@onready var enemies_projectiles_node = $Projectiles/Enemies


# Scrolling Background stuff
@onready var scrolling_background = $ScrollingBackground
@export var scroll_shader : ShaderMaterial

# Player weapon stuff
@export var current_weapon : WeaponBase
@onready var player_weapon_node = $PlayerWeapon


# For moving player to correct pos
var mouse_pos_before_pause : Vector2 

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	setup_scrolling_background()
	assign_player_weapon()
	Player.connect("weapon_changed", _on_weapon_changed)

func setup_scrolling_background():
	#scroll_shader.set_shader_parameter("speed", 0.05)
	scrolling_background.material = scroll_shader

func _on_weapon_changed(new_weapon):
	var all_weapons = player_weapon_node.get_children()
	for wp in all_weapons:
		wp.queue_free()
	assign_player_weapon()

func assign_player_weapon():
	var wp = Player.current_weapon as WeaponBase
	var wp_enum : Weapons.ProjectileType = wp.projectile_type
	var weapon_for_player = wp
	#player_weapon_node.add_child(weapon_for_player)
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
	


func _on_enemy_spawner_spawn_enemy_at(pos, enemy: EnemyBase):
	# connect signal for shoot, TODO: Make it universal
	enemy.connect("enemy_shoot", _on_enemy_simple_ufo_enemy_shoot)



func _on_enemy_kill_zone_body_entered(body):
	if "purge" in body:
		body.purge()


func _on_enemy_kill_zone_area_entered(area):
	if "purge" in area:
		area.purge()
