extends Node2D

var current_song_name = ""

func _ready():
	Signals.ChangeCurrentSong.connect(ChangeCurrentSong)
	
func ChangeCurrentSong(song_name):
	current_song_name = song_name
