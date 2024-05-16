extends WeaponBase

func _ready():
	weapon_name = "TripleWeapon"
	weapon_type = Weapons.WeaponType.TRIPPLE

func fire( pos: Vector2, dir: Vector2) -> Array[ProjectileBase]:
	print("Weapon name: ", weapon_name)
	var projectile1 = projectile_scene.instantiate() as ProjectileBase
	projectile1.position = pos
	projectile1.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	projectile1.direction = dir	
	var projectile2 = projectile_scene.instantiate() as ProjectileBase
	projectile2.position = pos
	projectile2.rotation_degrees = rad_to_deg(dir.angle()) + 90.0
	#bullet2.direction_vector = dir 
	var ang2 = deg_to_rad((projectile1.rotation_degrees) - 85.0)
	projectile2.direction = Vector2.from_angle(ang2)
	
	var projectile3 = projectile_scene.instantiate() as ProjectileBase
	projectile3.position = pos
	var ang3 = deg_to_rad((projectile1.rotation_degrees) - 95.0)
	projectile3.direction = Vector2.from_angle(ang3)
	
	var projectiles : Array[ProjectileBase] = [projectile1, projectile2, projectile3]
	return projectiles
