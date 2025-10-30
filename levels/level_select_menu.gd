extends Control

@export var level_buttons: ButtonGroup

func _ready():
	pass


func _on_exit_pressed() -> void:
	Signals.LoadMainMenu.emit()
	#Signals.GetNoteOffset().connect(GetNoteOffset)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/game_level.tscn")
	
func _song_button_pressed() -> void:
	var button_pressed = level_buttons.get_pressed_button()
	match button_pressed.name:
		"GLaBP":
			print("'Guitar, Loneliness and Blue Planet' Selected")
			Signals.ChangeCurrentSong.emit("guitar_loneliness_and_blue_planet")
		"NeverForget":
			print("'Never Forget' Selected")
			Signals.ChangeCurrentSong.emit("never_forget")
