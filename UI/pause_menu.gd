extends CanvasLayer
@onready var pause_menu = $Panel
@onready var settings_menu = $SettingsMenu

@export var game_manager : GameManager
var mouse_pos_before_pause : Vector2
signal unpause

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var mouse_pos_viewport = get_viewport().get_mouse_position()
		mouse_pos_before_pause = mouse_pos_viewport
		show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		get_viewport().warp_mouse(mouse_pos_before_pause)
		hide()


func _on_resume_button_pressed():
	game_manager.game_paused = false


func _on_settings_button_pressed():
	toggle_settings()

func toggle_settings():
	settings_menu.visible = !settings_menu.visible
	pause_menu.visible = !pause_menu.visible

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
