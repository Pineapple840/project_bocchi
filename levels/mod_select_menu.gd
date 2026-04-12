extends Control

@export var mod_buttons: ButtonGroup

@onready var mod_description = %ModDesciption

func _ready():
	ChangeModInfo(GlobalVariables.current_mod)

func _on_exit_button_pressed() -> void:
	Signals.LoadMenu.emit("LevelSelectMenu")


func _on_mod_button_pressed() -> void:
	var button_pressed = mod_buttons.get_pressed_button()
	match button_pressed.name:
		"Bocchi":
			Signals.ChangeCurrentMod.emit("bocchi")
			
		"Nijika":
			Signals.ChangeCurrentMod.emit("nijika")
			
		"Ryo":
			Signals.ChangeCurrentMod.emit("ryo")
		
		"Kita":
			Signals.ChangeCurrentMod.emit("kita")
	
	ChangeModInfo(button_pressed.name)
		
func ChangeModInfo(mod_name):
	match mod_name:
		"Bocchi":
			mod_description.text = "[i]Guitarhero[/i]\n[b]Hitori Gotō[/b]\n\nDefault gameplay"
			
		"Nijika":
			mod_description.text = "[i]Selfless Drummer Leader[/i]\n[b]Nijika Ijichi[/b]\n\nSudden notes"
			
		"Ryo":
			mod_description.text = "[i]Mysterious Bassist[/i]\n[b]Ryō Yamada[/b]\n\nHidden notes"
		
		"Kita":
			mod_description.text = "[i]Blinding Aura[/i]\n[b]Kita Ikuyo[/b]\n\nColour swap"
