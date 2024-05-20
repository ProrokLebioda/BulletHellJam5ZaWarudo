extends Node2D

signal spawn_enemy_at(pos, enemy : EnemyBase)

@onready var spawn_points = $SpawnPoints
@onready var enemies = $Enemies

# TEMP 
@onready var enemy_scene : PackedScene = preload("res://Scenes/Enemies/enemy_simple_ufo.tscn")


@export var spawn_continuously : bool = true
@export var enemy_types : Array[EnemyBase] = []
@export var enemy_scenes : Array[PackedScene] = []
@export var spawn_time : float = 3.0



func _on_spawn_timer_timeout():
	# Spawn and enemy at one of the possible positions
	var spawns = spawn_points.get_children()
	var spawn_point_count = spawns.size()
	var rand_spawn_point = spawns.pick_random()
	var new_enemy = enemy_scenes.pick_random().instantiate()
	new_enemy.position = rand_spawn_point.position
	spawn_enemy_at.emit(rand_spawn_point.global_position, new_enemy)
	enemies.add_child(new_enemy)
