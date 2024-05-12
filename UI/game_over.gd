extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_retry_button_pressed():
	# TODO: Change to access from global list
	Player.reset_player_stats()
	get_tree().change_scene_to_file("res://Levels/level.tscn")


func _on_main_meny_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()