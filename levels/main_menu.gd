extends Control


func _start_pressed():
	get_tree().change_scene_to_file("res://levels/game_level.tscn")

func _options_pressed():
	pass # Replace with function body.


func _extras_pressed():
	pass # Replace with function body.

func _close_game_pressed():
	get_tree().quit()
