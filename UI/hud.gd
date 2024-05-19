extends CanvasLayer

@onready var hp_value = $MarginContainer/VBoxContainer/HBoxContainer/HPValue
@onready var special_beam_texture = $MarginContainer/VBoxContainer/HBoxContainer2/SpecialBeamTexture
@export var beam_ready_texture : Texture2D
@export var beam_waiting_texture : Texture2D

func _ready():
	update_stat_ui()
	Player.connect("stat_change",update_stat_ui)
	
func update_stat_ui():
	update_health_text()

func update_health_text():
	hp_value.set_text(str(Player.health))
