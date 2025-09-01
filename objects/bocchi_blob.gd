extends Sprite2D

var del = 1
var animation: bool = false
var current_face = "happy"
var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()

var song_seconds_per_beat: float
var song_offset: float

var x = false

func _ready():
	
	Signals.ChangeBocchiBlobFace.connect(ChangeBocchiBlobFace)
	
	Signals.PlayVideo.connect(PlayVideo)
	Signals.PlayVideoConnected.emit()
	
	
	var beat_counter = 0

	
	#bounce(song_offset + time_delay)
	
func bounce(delay):
	await get_tree().create_timer(delay).timeout
	bounce(song_seconds_per_beat)
	
	if animation:
		position.y += 5
		animation = false
	elif current_face == "happy":
		position.y -= 5
		animation = true
		
func PlayVideo(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float):
	if not x:
		x = true
		song_seconds_per_beat = seconds_per_beat
		var bounce_start_delay = offset + time_delay - fmod(video_start_time, 0.7013478261)
		print(bounce_start_delay)
		
		bounce(bounce_start_delay)
		print("hi")
		
func ChangeBocchiBlobFace(face: String):
	match face:
		"sad":
			texture = load("res://art/bocchi_blob_sad.png")
			current_face = "sad"
		"happy":
			texture = load("res://art/bocchi_blob_happy.png")
			current_face = "happy"
			
	
		
			
