extends ProjectileBase

@export var rotation_amount_degrees: float = 28.0
# This moves sprite and collider on X axis, it enables 'rotation around centre'
@export var rotation_radius: float = 20.0
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	super()
	sprite_2d.move_local_x(rotation_radius)
	collision_shape_2d.move_local_x(rotation_radius)

func _physics_process(delta):
	rotate(deg_to_rad(rotation_amount_degrees))
	position += direction * speed * delta
	
func _on_body_entered(body):
	if "hit" in body:
		body.hit(projectile_damage)
	queue_free()
