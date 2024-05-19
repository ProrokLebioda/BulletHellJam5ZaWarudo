extends ItemPickup

@export var healing_power : int = 1 

func _on_body_entered(body):
	if !is_picked_up:
		Player.health += healing_power
		is_picked_up = true
		#insert code for play
		hide()
		#end play
		queue_free()
