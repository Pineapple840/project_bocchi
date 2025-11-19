extends Control

@onready var music_slider = $MarginContainer/VBoxContainer/MusicSetting/MusicSlider
@onready var music_val = $MarginContainer/VBoxContainer/MusicSetting/MusicVal

@onready var offset_slider = $MarginContainer/VBoxContainer/OffsetSetting/OffsetSlider
@onready var offset_val = $MarginContainer/VBoxContainer/OffsetSetting/OffsetVal

@onready var dim_slider = $MarginContainer/VBoxContainer/DimSetting/DimSlider
@onready var dim_val = $MarginContainer/VBoxContainer/DimSetting/DimVal

@onready var music_bus_index = AudioServer.get_bus_index("Music")

var music_volume = 0.5
var note_offset: float = 0.0
var background_dim: float = 0.15
var options_data = {}

func _ready():
	LoadOptions()


func _on_exit_pressed() -> void:
	Signals.LoadMenu.emit("MainMenu")
	#Signals.GetNoteOffset().connect(GetNoteOffset)


func _on_music_slider_value_changed(value: float) -> void:
	music_volume = value
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value *  2))
	music_val.text = str(int(value * 100)) + "%"
	
	SaveOptions()


func _on_offset_slider_value_changed(value: float) -> void:
	note_offset = value / 1000
	offset_val.text = str(int(value))
	
	SaveOptions()
	
func _on_dim_slider_value_changed(value: float) -> void:
	background_dim = value
	dim_val.text = str(int(value))  + "%"
	
	SaveOptions()
	
func GetNoteOffset() -> float:
	return note_offset
	
func SaveOptions():
	var file = FileAccess.open("user://game_settings.json", FileAccess.WRITE)
	options_data["music_volume"] = music_volume
	options_data["note_offset"] = note_offset
	options_data["background_dim"] = background_dim
	var json = JSON.stringify(options_data)
	file.store_string(json)
	file.close()
	
func LoadOptions():
	if FileAccess.file_exists("user://game_settings.json"):
		var file = FileAccess.open("user://game_settings.json", FileAccess.READ)
		var json = file.get_as_text()
		options_data = JSON.parse_string(json)
		music_volume = options_data["music_volume"]
		note_offset = options_data["note_offset"]
		background_dim = options_data["background_dim"]
		
		music_slider.value = music_volume
		music_val.text = str(int(music_volume * 100)) + "%"
		offset_slider.value = note_offset * 1000
		offset_val.text = str(int(note_offset * 1000))
		dim_slider.value = background_dim
		dim_val.text = str(int(background_dim)) + "%"
	
	
		file.close()
	
