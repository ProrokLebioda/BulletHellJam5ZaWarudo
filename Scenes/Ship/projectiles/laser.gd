extends ProjectileBase
class_name LaserBase

func _on_body_entered(body):
	#if "hit" in body:
	body.hit(projectile_damage)
	queue_free()

func purge():
	queue_free()
