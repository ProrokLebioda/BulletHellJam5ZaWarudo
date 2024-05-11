extends Area2D
class_name ProjectileBase

var direction : Vector2 = Vector2()
@onready var lifetime_timer : Timer = Timer.new()
@export var speed : float = 600
@export var projectile_lifetime : float = 2
@export var projectile_damage : int = 2

func _ready():
	#get_tree().add_child(lifetime_timer)
	add_child(lifetime_timer)
	lifetime_timer.connect("timeout", _on_lifetime_timer_timeout)
	lifetime_timer.start(projectile_lifetime)

func _physics_process(delta):
	position += direction * speed * delta
	
	
func _on_lifetime_timer_timeout():
	queue_free()
	
