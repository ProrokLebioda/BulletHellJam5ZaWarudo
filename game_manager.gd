extends Node
class_name GameManager
@onready var level = $Level
@onready var pause_menu = $UI/PauseMenu
@onready var scrolling_bg = $Level/ScrollingBackground
@export var scrolling_shader : ShaderMaterial

# For moving player to correct pos
var mouse_pos_before_pause : Vector2 

signal toggle_game_paused(is_paused : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(val):
		game_paused = val
		get_tree().paused = game_paused
		scrolling_shader.set_shader_parameter("speed", 0 if val else Player.scroll_speed)
		scrolling_bg.material = scrolling_shader
		toggle_game_paused.emit(game_paused)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_pause()

func _on_pause():
	if !game_paused:
		var mouse_pos_viewport = get_viewport().get_mouse_position()
		mouse_pos_before_pause = mouse_pos_viewport
		
	game_paused = !game_paused
	if game_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		#Input.warp_mouse(mouse_pos_before_pause)
		get_viewport().warp_mouse(mouse_pos_before_pause)

	
	
