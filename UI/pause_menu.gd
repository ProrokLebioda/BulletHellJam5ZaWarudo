extends CanvasLayer

@export var game_manager : GameManager

signal unpause

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _on_game_manager_toggle_game_paused(is_paused : bool):
	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		hide()


func _on_resume_button_pressed():
	game_manager.game_paused = false


func _on_settings_button_pressed():
	pass # Replace with function body.


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
