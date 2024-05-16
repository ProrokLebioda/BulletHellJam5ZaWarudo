extends Node

enum ProjectileType{BASIC, LASER, ROCKET, HOMING, ROTATING}

enum WeaponType{SINGLE, DOUBLE, TRIPPLE}

@onready var basic_weapon : WeaponBase
@onready var basic_weapon_scene : PackedScene = preload("res://Scenes/Weapons/weapon.tscn")
@onready var double_weapon : PackedScene = preload("res://Scenes/Weapons/double_weapon.tscn")
@onready var triple_weapon_scene : PackedScene = preload("res://Scenes/Weapons/triple_weapon.tscn")

@onready var basic_projectile : ProjectileBase
@onready var basic_projectile_scene : PackedScene = preload("res://Scenes/Ship/projectiles/player_laser.tscn")
@onready var laser_projectile_scene : PackedScene = preload("res://Scenes/Ship/projectiles/player_laser.tscn")
@onready var rotating_projectile_scene : PackedScene = preload("res://Scenes/Ship/projectiles/rotating_projectile.tscn")

@onready var weapons : Dictionary
@onready var projectiles : Dictionary
@onready var projectiles_scenes : Dictionary

@onready var weapon : WeaponBase

func get_basic_weapon() -> WeaponBase:
	if !basic_weapon:
		basic_weapon = triple_weapon_scene.instantiate()
	return basic_weapon

func get_projectile(type : ProjectileType) -> ProjectileBase:
	if !projectiles[type]:
		populate_projectiles()
		if !projectiles[type]:
			return projectiles[type]
	return projectiles[type]

func get_projectile_scene(type : ProjectileType) -> PackedScene:
	if !projectiles_scenes[type]:
		populate_projectiles_scenes()
		if !projectiles_scenes[type]:
			return projectiles_scenes[type]
	return projectiles_scenes[type]

func get_weapon(type :WeaponType) -> WeaponBase:
	
	if !weapons[type]:
		populate_weapons()
		if !weapons[type]:
			return weapons[type]
	return weapons[type]


func populate_weapons():
	weapons[WeaponType.SINGLE] = basic_weapon_scene.instantiate()
	weapons[WeaponType.DOUBLE] = double_weapon.instantiate()
	weapons[WeaponType.TRIPPLE] = triple_weapon_scene.instantiate()
#	weapons[ProjectileType.ROTATING] = rotating_weapon_scene
func populate_projectiles():
	projectiles[ProjectileType.BASIC] = basic_projectile_scene.instantiate()
	projectiles[ProjectileType.LASER] = laser_projectile_scene.instantiate()
	projectiles[ProjectileType.ROTATING] = rotating_projectile_scene.instantiate()
func populate_projectiles_scenes():
	projectiles_scenes[ProjectileType.BASIC] = basic_projectile_scene
	projectiles_scenes[ProjectileType.LASER] = laser_projectile_scene
	projectiles_scenes[ProjectileType.ROTATING] = rotating_projectile_scene

func _ready():
	populate_weapons()
	populate_projectiles_scenes()
	populate_projectiles()
		
func projectile_string_to_enum(name: String) ->ProjectileType:
	match(name):
		"Laser":
			return ProjectileType.LASER
		"Rocket":
			return ProjectileType.ROCKET
		"Homing":
			return ProjectileType.HOMING
		"Rotating":
			return ProjectileType.ROTATING
	return ProjectileType.BASIC

func projectile_enum_to_string(en : ProjectileType)-> String:
	match(en):
		ProjectileType.LASER:
			return "Laser"
		ProjectileType.ROCKET:
			return "Rocket"
		ProjectileType.HOMING:
			return "Homing"
		ProjectileType.ROTATING:
			return "Rotating"
	return "WeaponBase"



func get_all_available_weapons() -> Dictionary:
	return weapons
