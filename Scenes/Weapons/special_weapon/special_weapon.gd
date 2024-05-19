extends Node2D
class_name SpecialWeapon

@export var special_scene : PackedScene

var weapon_name : String = "SpecialWeapon"
@export var projectile_type : Weapons.ProjectileType = Weapons.ProjectileType.BASIC 
@export var weapon_type : Weapons.WeaponType = Weapons.WeaponType.SINGLE
var special : SpecialAttack

func _ready():
	pass

func fire():
	print("Weapon name: ", weapon_name)
	special = special_scene.instantiate() as SpecialAttack
	return special
