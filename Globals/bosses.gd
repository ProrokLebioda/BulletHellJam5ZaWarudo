extends Node

var possible_upgrades_scenes : Array[PackedScene]

@onready var double_pickup : PackedScene = preload("res://Interactables/Pickups/weapon_pickups/double_pickup.tscn")
@onready var triple_pickup : PackedScene = preload("res://Interactables/Pickups/weapon_pickups/triple_pickup.tscn")
@onready var rotating_projectile : PackedScene = preload("res://Interactables/Pickups/projectiles_pickups/rotating_projectile_pickup.tscn")

func _ready():
	generate_loot_table()

func generate_loot_table():
	possible_upgrades_scenes.append(double_pickup)
	possible_upgrades_scenes.append(triple_pickup)
	possible_upgrades_scenes.append(rotating_projectile)


func get_random_pickup() -> PackedScene:
	return possible_upgrades_scenes.pick_random()
