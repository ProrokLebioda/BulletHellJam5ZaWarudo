extends CharacterBody2D
class_name EnemyBase
@export var invulnerable_time: float = 0.3
@onready var invulnerable_timer = $Timers/InvulnerableTimer

var health : int = 4
var speed : float = 100.0
var dir: Vector2 = Vector2.DOWN
var is_vulnerable : bool = true

func _physics_process(delta):
	velocity = dir * speed 
	move_and_slide()
	
func hit(damage : int):
	if is_vulnerable:
		health-=damage
		is_vulnerable = false
		invulnerable_timer.start(invulnerable_time)
		
	if health <= 0:
		health = 0
		queue_free()


func _on_invulnerable_timer_timeout():
	is_vulnerable = true
