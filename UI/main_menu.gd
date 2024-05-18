extends CanvasLayer

@onready var main_menu_container = $MarginContainer

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var settings_button = $MarginContainer/VBoxContainer/SettingsButton
@onready var credits_button = $MarginContainer/VBoxContainer/CreditsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton


@onready var settings_menu = $SettingsMenu
@onready var settings_back_button = $SettingsMenu/MarginContainer/VBoxContainer/BackButton
@onready var credits = $Credits

func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()

# Settings
	
func _on_back_button_pressed():
	pass # Replace with function body.
