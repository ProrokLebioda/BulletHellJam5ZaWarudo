extends Node
class_name GameManager
@onready var level = $Level
@onready var pause_menu = $UI/PauseMenu

signal toggle_game_paused(is_paused : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(val):
		game_paused = val
		get_tree().paused = game_paused
		toggle_game_paused.emit(game_paused)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_pause()

func _on_pause():
	game_paused = !game_paused
	if game_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

	
	
