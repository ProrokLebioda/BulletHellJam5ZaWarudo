extends CanvasLayer
@export var game_over_music : AudioStream
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	AudioPlayer._play_music(game_over_music, -12.0)

func _on_retry_button_pressed():
	# TODO: Change to access from global list
	Player.reset_player_stats()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
