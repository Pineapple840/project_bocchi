extends Node2D

var current_song_name = ""
var current_mod = "bocchi"

var score_data = {
	"score": 0,
	"accuracy" : 0
}

func _ready():
	Signals.ChangeCurrentSong.connect(ChangeCurrentSong)
	Signals.ChangeCurrentMod.connect(ChangeCurrentMod)
	
func ChangeCurrentSong(song_name):
	current_song_name = song_name

func ChangeCurrentMod(mod_name):
	current_mod = mod_name
