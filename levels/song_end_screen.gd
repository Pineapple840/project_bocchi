extends Control

func _ready():
	var score = GlobalVariables.score_data["score"]
	var accuracy = GlobalVariables.score_data["accuracy"]
	
	%Score.text = "Score: " + str(score)
	%Accuracy.text = "Accuracy: " + ("%.02f" % accuracy) + "%"
	
	if accuracy == 100:
		%Grade.text = "SS"
		%Grade.set("theme_override_colors/default_color", Color("ffb300"))
	elif accuracy >= 95:
		%Grade.text = "S"
		%Grade.set("theme_override_colors/default_color", Color("fdfd00"))
	elif accuracy >= 90:
		%Grade.text = "A"
		%Grade.set("theme_override_colors/default_color", Color("00ff00"))
	elif accuracy >= 85:
		%Grade.text = "B"
		%Grade.set("theme_override_colors/default_color", Color("0055ff"))
	elif accuracy >= 80:
		%Grade.text = "C"
		%Grade.set("theme_override_colors/default_color", Color("a600ff"))
	else:
		%Grade.text = "D"
		%Grade.set("theme_override_colors/default_color", Color("ff0000"))
		
func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://levels/game_level.tscn")

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://levels/main_menu.tscn")
