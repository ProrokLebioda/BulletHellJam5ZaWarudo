extends Node2D
class_name WeaponBase

var weapon_name : String = "WeaponBase"
@export var weapon_type : Weapons.WeaponType = Weapons.WeaponType.BASIC 


func fire( pos: Vector2, dir: Vector2) -> Array[ProjectileBase]:
	print("")
	
	var projectiles: Array[ProjectileBase]
	return projectiles
