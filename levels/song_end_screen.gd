extends Control

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://levels/game_level.tscn")

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
