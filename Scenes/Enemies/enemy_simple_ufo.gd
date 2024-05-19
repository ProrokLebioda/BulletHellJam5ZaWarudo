extends EnemyBase


func _on_hurt_area_body_entered(body):
	if "hit" in body:
		body.hit(collision_damage)
		hit(Player.ram_damage)
