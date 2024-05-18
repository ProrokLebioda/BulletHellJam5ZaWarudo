extends Node2D
class_name BossBase
@onready var path_follow_2d = $Paths/Path2D/PathFollow2D

signal enemy_shoot(pos : Vector2, dir : Vector2, projectile: ProjectileBase)

func _ready():
	if path_follow_2d.get_child(0):
		for boss in path_follow_2d.get_children():
			boss.connect("boss_shoot", _on_boss_body_boss_shoot)

func _physics_process(delta):
	progress_path(delta)

func progress_path(delta):
	path_follow_2d.progress_ratio += delta*0.1

func _on_boss_body_boss_shoot(pos, dir, projectile):
	enemy_shoot.emit(pos, dir, projectile)
