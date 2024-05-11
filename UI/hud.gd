extends CanvasLayer

@onready var hp_value = $MarginContainer/VBoxContainer/HBoxContainer/HPValue


func _ready():
	Player.connect("stat_change",update_stat_ui)
	
func update_stat_ui():
	update_health_text()

func update_health_text():
	hp_value.set_text(str(Player.health))
