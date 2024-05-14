extends Node

enum ProjectileType{BASIC, LASER, ROCKET, HOMING, ROTATING}

enum WeaponType{SINGLE, DOUBLE, TRIPPLE}

@onready var basic_weapon : WeaponBase
@onready var basic_weapon_scene : PackedScene = preload("res://Scenes/Weapons/weapon.tscn")
@onready var triple_weapon_scene : PackedScene = preload("res://Scenes/Weapons/triple_weapon.tscn")

@onready var weapons : Dictionary

@onready var weapon : WeaponBase

func get_basic_weapon() -> WeaponBase:
	if !basic_weapon:
		basic_weapon = triple_weapon_scene.instantiate()
	return basic_weapon

func get_weapon(type :WeaponType) -> WeaponBase:
	
	if !weapons[type]:
		populate_weapons()
		if !weapons[type]:
			return weapons[type]
	return weapons[type]


func populate_weapons():
	weapons[WeaponType.SINGLE] = basic_weapon_scene.instantiate()
	weapons[WeaponType.TRIPPLE] = triple_weapon_scene.instantiate()
#	weapons[ProjectileType.ROTATING] = rotating_weapon_scene

func _ready():
	populate_weapons()
		
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
