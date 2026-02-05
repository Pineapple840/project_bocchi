"""Handles the icon on the bottom right which moves in time with the music"""

extends Sprite2D

var del = 1
var animation: bool = false
var current_face = "happy"
var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()

var song_seconds_per_beat: float
var song_offset: float

var run_once = false
var bounce_processing = false


var happy_face
var sad_face
var nijika_left_drum
var nijika_right_drum

func _ready():
	
	Signals.ChangeBocchiBlobFace.connect(ChangeBocchiBlobFace)
	
	Signals.LevelStart.connect(LevelStart)
	Signals.PlayVideoConnected.emit()
	
	
	var beat_counter = 0
	
	match GlobalVariables.current_mod:
		"bocchi":
			happy_face = load("res://art/bocchi_blobs/bocchi_blob_happy.png")
			sad_face = load("res://art/bocchi_blobs/bocchi_blob_sad.png")
			
		"nijika":
			
			
			nijika_left_drum = load("res://art/bocchi_blobs/nijika_blob_1.png")
			nijika_right_drum = load("res://art/bocchi_blobs/nijika_blob_2.png")
			
			happy_face = nijika_left_drum
			sad_face = load("res://art/bocchi_blobs/nijika_blob_sad.png")
			
		"ryo":
			happy_face = load("res://art/bocchi_blobs/ryo_blob_happy.png")
			sad_face = load("res://art/bocchi_blobs/ryo_blob_sad.png")
			
		"kita":
			happy_face = load("res://art/bocchi_blobs/kita_blob_happy.png")
			sad_face = load("res://art/bocchi_blobs/kita_blob_sad.png")
		
	texture = happy_face
	
	#bounce(song_offset + time_delay)
	
func bounce(delay):
	await get_tree().create_timer(delay, false).timeout
	bounce(song_seconds_per_beat)
	
	if animation:
		if GlobalVariables.current_mod == "nijika":
			texture = nijika_right_drum
		else:
			position.y += 5
		animation = false
	elif current_face == "happy":
		if GlobalVariables.current_mod == "nijika":
			texture = nijika_left_drum
		else:
			position.y -= 5
		animation = true
		
func LevelStart(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float):
	if not run_once:
		run_once = true
		song_seconds_per_beat = seconds_per_beat
		var bounce_start_delay = offset - fmod(video_start_time, seconds_per_beat)
		print(bounce_start_delay)
		
		bounce(bounce_start_delay)
		
func ChangeBocchiBlobFace(face: String):
	match face:
		"sad":
			texture = sad_face
			current_face = "sad"
		"happy":
			if GlobalVariables.current_mod == "nijika":
				if texture == sad_face:
					texture = happy_face
			else:
				texture = happy_face
				current_face = "happy"

			
	
		
			
