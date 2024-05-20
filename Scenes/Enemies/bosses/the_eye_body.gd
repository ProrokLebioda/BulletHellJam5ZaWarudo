extends BossBody

@export var rotation_amount_degrees : float = 5.0

func _physics_process(delta):
	dir = dir.rotated(deg_to_rad(rotation_amount_degrees))
	super(delta)
	rotate(deg_to_rad(rotation_amount_degrees))
