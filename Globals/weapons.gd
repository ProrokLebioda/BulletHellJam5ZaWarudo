extends Node

enum WeaponType{BASIC, LASER, ROCKET, HOMING, ROTATING}

@onready var basic_weapon : WeaponBase
@onready var basic_weapon_scene : PackedScene = preload("res://Scenes/Weapons/weapon.tscn")


@onready var weapons : Dictionary

func get_basic_weapon() -> WeaponBase:
	if !basic_weapon:
		basic_weapon = basic_weapon_scene.instantiate()
	return basic_weapon

func _ready():
	weapons[WeaponType.BASIC] = basic_weapon_scene.instantiate()
#	weapons[WeaponType.TRIPPLE] = triple_weapon_scene
#	weapons[WeaponType.ROTATING] = rotating_weapon_scene
		
func weapon_string_to_enum(name: String) ->WeaponType:
	match(name):
		"Laser":
			return WeaponType.LASER
		"Rocket":
			return WeaponType.ROCKET
		"Homing":
			return WeaponType.HOMING
		"Rotating":
			return WeaponType.ROTATING
	return WeaponType.BASIC

func weapon_enum_to_string(en : WeaponType)-> String:
	match(en):
		WeaponType.LASER:
			return "Laser"
		WeaponType.ROCKET:
			return "Rocket"
		WeaponType.HOMING:
			return "Homing"
		WeaponType.ROTATING:
			return "Rotating"
	return "WeaponBase"



func get_all_available_weapons() -> Dictionary:
	return weapons
