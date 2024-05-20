extends Node

enum State{IDLE, MOVING, SHOOTING}

var possible_upgrades_scenes : Array[PackedScene]

@onready var health_pickup : PackedScene = preload("res://Interactables/Pickups/general_pickups/health_pickup.tscn")

func _ready():
	generate_loot_table()

func generate_loot_table():
	possible_upgrades_scenes.append(health_pickup)


func get_random_pickup() -> PackedScene:
	return possible_upgrades_scenes.pick_random()
