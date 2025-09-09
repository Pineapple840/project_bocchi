extends Control

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("button_ESC"):
		if get_tree().paused:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true

func _on_resume_button_pressed():
	hide()
	get_tree().paused = false

func _on_restart_button_pressed():
	hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
