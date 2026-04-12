extends Control


func _on_exit_button_pressed() -> void:
	Signals.LoadMenu.emit("MainMenu")
