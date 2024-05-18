extends Area2D
class_name ItemPickup
var is_picked_up : bool = false
var direction : Vector2 = Vector2.DOWN
@export var speed : float = 2000
func _physics_process(delta):
	position += direction * Player.scroll_speed * speed * delta
	pass


func purge():
	queue_free()
