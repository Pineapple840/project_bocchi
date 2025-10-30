extends Control

@onready var MainMenuItems = $MainMenuItems
@onready var OptionsMenu = $OptionsMenu
@onready var LevelSelectMenu = $LevelSelectMenu

func _ready():
	Signals.LoadMainMenu.connect(LoadMainMenu)

func _start_pressed():
	MainMenuItems.visible = false
	LevelSelectMenu.visible = true
	#get_tree().change_scene_to_file("res://levels/game_level.tscn")

func _options_pressed():
	MainMenuItems.visible = false
	OptionsMenu.visible = true
	


func _extras_pressed():
	pass # Replace with function body.

func _close_game_pressed():
	get_tree().quit()
	
func LoadMainMenu():
	MainMenuItems.visible = true
	LevelSelectMenu.visible = false
	OptionsMenu.visible = false
