extends Node2D
class_name WeaponBase

# Change later or in derived scenes
@onready var projectile_scene : PackedScene = preload("res://Scenes/Ship/projectiles/player_laser.tscn")

var weapon_name : String = "WeaponBase"
@export var weapon_type : Weapons.WeaponType = Weapons.WeaponType.BASIC 


func fire( pos: Vector2, dir: Vector2) -> Array[ProjectileBase]:
	print("Weapon name: ", weapon_name)
	var projectile = projectile_scene.instantiate() as ProjectileBase
	projectile.position = pos
	# check if rotation is correct
	projectile.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	projectile.direction = dir
	
	
	var projectiles: Array[ProjectileBase] = [projectile]
	return projectiles