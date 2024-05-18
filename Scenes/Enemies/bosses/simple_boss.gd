extends Node2D
class_name BossBase
@onready var path_follow_2d = $Paths/Path2D/PathFollow2D

@export var is_last_boss : bool = false

signal enemy_shoot(pos : Vector2, dir : Vector2, projectile: ProjectileBase)

func _ready():
	is_last_boss = true
	if path_follow_2d.get_child(0):
		for boss in path_follow_2d.get_children():
			boss.connect("boss_shoot", _on_boss_body_boss_shoot)
			boss.connect("boss_died",_on_boss_died)

func _physics_process(delta):
	progress_path(delta)

func progress_path(delta):
	path_follow_2d.progress_ratio += delta*0.1

func _on_boss_body_boss_shoot(pos, dir, projectile):
	enemy_shoot.emit(pos, dir, projectile)

func _on_boss_died():
	if is_last_boss:
		get_tree().change_scene_to_file("res://UI/game_complete.tscn")
	call_deferred("queue_free")
