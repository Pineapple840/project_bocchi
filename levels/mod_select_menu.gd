extends Control

@export var mod_buttons: ButtonGroup

@onready var mod_description = %ModDesciption

func _on_exit_button_pressed() -> void:
	Signals.LoadMenu.emit("LevelSelectMenu")


func _on_mod_button_pressed() -> void:
	var button_pressed = mod_buttons.get_pressed_button()
	match button_pressed.name:
		"Bocchi":
			Signals.ChangeCurrentMod.emit("bocchi")
			mod_description.text = "[i]Guitarhero[/i]\n[b]Hitori Gotō[/b]\n\nDefault gameplay"
			
		"Nijika":
			Signals.ChangeCurrentMod.emit("nijika")
			mod_description.text = "[i]The Selfless Drummer Leader[/i]\n[b]Nijika Ijichi[/b]\n\nSudden notes"
		
