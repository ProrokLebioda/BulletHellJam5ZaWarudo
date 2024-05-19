extends Node2D
class_name SpecialWeapon

@export var special_scene : PackedScene
@export var beam_vfx : AudioStream
var weapon_name : String = "SpecialWeapon"
@export var projectile_type : Weapons.ProjectileType = Weapons.ProjectileType.BASIC 
@export var weapon_type : Weapons.WeaponType = Weapons.WeaponType.SINGLE
var special : SpecialAttack

func _ready():
	pass

func fire():
	print("Weapon name: ", weapon_name)
	special = special_scene.instantiate() as SpecialAttack
	AudioPlayer.play_FX(beam_vfx, -12.0)
	return special
