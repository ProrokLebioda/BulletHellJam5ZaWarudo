extends Node2D

signal spawn_boss_at(pos, enemy : BossBase)

@onready var spawn_points = $SpawnPoints
@onready var enemies = $Enemies

# TEMP 
@onready var enemy_scene : PackedScene = preload("res://Scenes/Enemies/enemy_simple_ufo.tscn")
@onready var spawn_timer = $Timers/SpawnTimer


@export var spawn_continuously : bool = true
@export var boss_types : Array[BossBase] = []
@export var boss_scenes : Array[PackedScene] = []
@export var spawn_time : float = 3.0

func _ready():
	spawn_timer.start(spawn_time)

func _on_spawn_timer_timeout():
	# Spawn and enemy at one of the possible positions
	var spawns = spawn_points.get_children()
	var spawn_point_count = spawns.size()
	var rand_spawn_point = spawns.pick_random()
	var new_boss = boss_scenes.pick_random().instantiate() as BossBase
	new_boss.position = rand_spawn_point.position
	if Player.killed_bosses >= 4: 
		new_boss.is_last_boss = true
	spawn_boss_at.emit(rand_spawn_point.global_position, new_boss)
	enemies.add_child(new_boss)
