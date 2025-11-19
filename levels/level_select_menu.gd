extends Control

@export var level_buttons: ButtonGroup

@onready var current_mod_display = %CurrentModDisplay

func _ready():
	Signals.ChangeCurrentMod.connect(ChangeModDisplay)
	ChangeModDisplay(GlobalVariables.current_mod)

func _on_mods_pressed() -> void:
	Signals.LoadMenu.emit("ModSelectMenu")
	
func _on_exit_pressed() -> void:
	Signals.LoadMenu.emit("MainMenu")
	#Signals.GetNoteOffset().connect(GetNoteOffset)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/game_level.tscn")
	
func _song_button_pressed() -> void:
	var button_pressed = level_buttons.get_pressed_button()
	match button_pressed.name:
		"SeishunComplex":
			print("'Seishun Complex' Selected")
			Signals.ChangeCurrentSong.emit("seishun_complex")
		"GLaBP":
			print("'Guitar, Loneliness and Blue Planet' Selected")
			Signals.ChangeCurrentSong.emit("guitar_loneliness_and_blue_planet")
		"NeverForget":
			print("'Never Forget' Selected")
			Signals.ChangeCurrentSong.emit("never_forget")
			
func ChangeModDisplay(mod_name):
	match mod_name:
		"bocchi":
			current_mod_display.texture = load("res://art/bocchi_blobs/bocchi_blob_happy.png")
		"nijika":
			current_mod_display.texture = load("res://art/bocchi_blobs/nijika_blob_1.png")
			
		
