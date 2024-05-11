extends Area2D
class_name ProjectileBase

var direction : Vector2 = Vector2()
@onready var lifetime_timer : Timer = Timer.new()
@export var speed : float = 100
@export var projectile_lifetime : float = 4
@export var projectile_damage : int = 2

func _ready():
	get_tree().add_child(lifetime_timer)
	lifetime_timer.connect("timeout", _on_lifetime_timer_timeout)

func _physics_process(delta):
	position += direction * speed * delta
	
	
func _on_lifetime_timer_timeout():
	queue_free()
	
