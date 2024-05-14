extends Node2D
class_name WeaponBase

# Change later or in derived scenes
@onready var projectile_scene : PackedScene = preload("res://Scenes/Ship/projectiles/player_laser.tscn")

@export var custom_projectile_scene : PackedScene
var weapon_name : String = "WeaponBase"
@export var projectile_type : Weapons.ProjectileType = Weapons.ProjectileType.BASIC 
@export var weapon_type : Weapons.WeaponType = Weapons.WeaponType.SINGLE
var projectile : ProjectileBase

func _ready():
	if custom_projectile_scene != null:
		projectile_scene = custom_projectile_scene

func fire( pos: Vector2, dir: Vector2) -> Array[ProjectileBase]:
	print("Weapon name: ", weapon_name)
	projectile = projectile_scene.instantiate() as ProjectileBase
		
	projectile.position = pos
	# check if rotation is correct
	projectile.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	projectile.direction = dir
	
	
	var projectiles: Array[ProjectileBase] = [projectile]
	return projectiles
