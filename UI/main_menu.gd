extends CanvasLayer

@onready var main_menu_container = $MarginContainer

@onready var new_game_button = $MarginContainer/VBoxContainer/NewGameButton
@onready var settings_button = $MarginContainer/VBoxContainer/SettingsButton
@onready var credits_button = $MarginContainer/VBoxContainer/CreditsButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton

@onready var settings_menu = $SettingsMenu
@onready var settings_back_button = $SettingsMenu/Panel/MarginContainer/VBoxContainer/BackButton
@onready var credits_screen = $CreditsScreen

@export var main_menu_music : AudioStream

func _ready():
	if get_tree().paused:
		get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	AudioPlayer._play_music(main_menu_music, -10.0)

func _on_new_game_button_pressed():
	Player.reset_player_stats()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_settings_button_pressed():
	toggle_settings_menu()

func _on_credits_button_pressed():
	credits_screen.visible = !credits_screen.visible
	main_menu_container.visible = !main_menu_container.visible

func _on_quit_button_pressed():
	get_tree().quit()

# Settings
	
func _on_back_button_pressed():
	toggle_settings_menu()

func toggle_settings_menu():
	settings_menu.visible = !settings_menu.visible
	if settings_menu.visible:
		settings_back_button.grab_focus()
	
	main_menu_container.visible = !main_menu_container.visible
	if main_menu_container.visible:
		settings_button.grab_focus()


#func _on_toggle_credits():
	
