extends WeaponBase

func _ready():
	weapon_name = "DoubleWeapon"
	weapon_type = Weapons.WeaponType.DOUBLE

func fire( pos: Vector2, dir: Vector2) -> Array[ProjectileBase]:
	print("Weapon name: ", weapon_name)
	
	var projectile1 = projectile_scene.instantiate() as ProjectileBase
	projectile1.position = pos
	projectile1.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	var ang1 =  deg_to_rad((projectile1.rotation_degrees) - 100.0)
	projectile1.direction = Vector2.from_angle(ang1)	
	
	var projectile2 = projectile_scene.instantiate() as ProjectileBase
	projectile2.position = pos
	projectile2.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	var ang2 = deg_to_rad((projectile1.rotation_degrees) - 80.0)
	projectile2.direction = Vector2.from_angle(ang2)
	
	var projectiles : Array[ProjectileBase] = [projectile1, projectile2]
	return projectiles
