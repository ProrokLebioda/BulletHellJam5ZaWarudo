extends ItemPickup
class_name DoubleWeaponPickup
@export var weapon_enum : Weapons.WeaponType = Weapons.WeaponType.DOUBLE

func _on_body_entered(body):
	if !is_picked_up:
		
		Player.curren_weapon_type = weapon_enum
		Player.current_weapon = null
		AudioPlayer.play_FX(pickup_sound, -12.0)
		is_picked_up = true
		#insert code for play
		hide()
		#end play
		queue_free()
