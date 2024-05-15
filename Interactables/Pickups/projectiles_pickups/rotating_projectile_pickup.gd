extends ItemPickup
@export var projectile_enum : Weapons.ProjectileType = Weapons.ProjectileType.ROTATING


func _on_body_entered(body):
	if !is_picked_up:
		
		Player.current_projectile = Weapons.get_projectile_scene(projectile_enum)

		is_picked_up = true
		#insert code for play
		hide()
		#end play
		queue_free()
