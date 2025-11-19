extends Control

@onready var MainMenuItems = $MainMenuItems
@onready var OptionsMenu = $OptionsMenu
@onready var LevelSelectMenu = $LevelSelectMenu
@onready var ModSelectMenu = $ModSelectMenu

func _ready():
	Signals.LoadMenu.connect(LoadMenu)
	

	

func _start_pressed():
	LoadLevelSelectMenu()

func _options_pressed():
	LoadOptionsMenu()

	


func _extras_pressed():
	pass # Replace with function body.

func _close_game_pressed():
	get_tree().quit()
	
func LoadMenu(menu: String):
	match menu:
		"MainMenu":
			LoadMainMenu()
		"LevelSelectMenu":
			LoadLevelSelectMenu()
		"OptionsMenu":
			LoadOptionsMenu()
		"ModSelectMenu":
			LoadModSelectMenu()
	
func LoadMainMenu():
	MainMenuItems.visible = true
	LevelSelectMenu.visible = false
	OptionsMenu.visible = false
	
func LoadLevelSelectMenu():
	MainMenuItems.visible = false
	LevelSelectMenu.visible = true
	ModSelectMenu.visible = false
	
func LoadOptionsMenu():
	MainMenuItems.visible = false
	OptionsMenu.visible = true
	
func LoadModSelectMenu():
	LevelSelectMenu.visible = false
	ModSelectMenu.visible = true
