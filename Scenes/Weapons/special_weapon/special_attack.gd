extends Area2D
class_name SpecialAttack
@onready var animation_player = $AnimationPlayer

var direction : Vector2 = Vector2()
@onready var lifetime_timer : Timer = Timer.new()
@onready var damage_apply_timer : Timer = Timer.new()
@export var speed : float = 600
@export var projectile_lifetime : float = 2
@export var projectile_damage : int = 2
@export var damage_interval : float = 0.01
var enemies_in_area: Array

func _ready():
	#get_tree().add_child(lifetime_timer)
	enemies_in_area = []
	add_child(lifetime_timer)
	lifetime_timer.connect("timeout", _on_lifetime_timer_timeout)
	lifetime_timer.start(projectile_lifetime)
	animation_player.play("shoot_beam")
	add_child(damage_apply_timer)
	damage_apply_timer.connect("timeout", _on_damage_apply_timer_timeout)
	damage_apply_timer.start(damage_interval)
	
	
func _on_lifetime_timer_timeout():
	queue_free()
	
func _on_damage_apply_timer_timeout():
	for enemy in enemies_in_area:
		if "hit" in enemy:
			enemy.hit(projectile_damage)
		elif "purge" in enemy:
			enemy.purge()


func _on_area_entered(area):
	if "purge" in area and area not in enemies_in_area:
		enemies_in_area.append(area)


func _on_area_exited(area):
	if area in enemies_in_area:
		enemies_in_area.erase(area)


func _on_body_entered(body):
	if "hit" in body and body not in enemies_in_area:
		enemies_in_area.append(body)


func _on_body_exited(body):
	if body in enemies_in_area:
		enemies_in_area.erase(body)
