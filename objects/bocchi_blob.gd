extends Sprite2D

var del = 1
var animation: bool = false
var current_face = "happy"
var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()

var song_seconds_per_beat: float
var song_offset: float

var run_once = false
var bounce_processing = false

var bocchi_happy
var bocchi_sad
var nijika_happy_1
var nijika_happy_2
var nijika_sad

func _ready():
	
	Signals.ChangeBocchiBlobFace.connect(ChangeBocchiBlobFace)
	
	Signals.LevelStart.connect(LevelStart)
	Signals.PlayVideoConnected.emit()
	
	
	var beat_counter = 0
	
	match GlobalVariables.current_mod:
		"bocchi":
			bocchi_happy = load("res://art/bocchi_blobs/bocchi_blob_happy.png")
			bocchi_sad = load("res://art/bocchi_blobs/bocchi_blob_sad.png")
			texture = bocchi_happy
		"nijika":
			nijika_happy_1 = load("res://art/bocchi_blobs/nijika_blob_1.png")
			nijika_happy_2 = load("res://art/bocchi_blobs/nijika_blob_2.png")
			nijika_sad = load("res://art/bocchi_blobs/nijika_blob_sad.png")
			texture = nijika_happy_1

	
	#bounce(song_offset + time_delay)
	
func bounce(delay):
	await get_tree().create_timer(delay, false).timeout
	bounce(song_seconds_per_beat)
	
	if animation:
		if GlobalVariables.current_mod == "nijika":
			texture = nijika_happy_2
		else:
			position.y += 5
		animation = false
	elif current_face == "happy":
		if GlobalVariables.current_mod == "nijika":
			texture = nijika_happy_1
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
			match GlobalVariables.current_mod:
				"bocchi":
					texture = bocchi_sad
				"nijika":
					texture = nijika_sad
			current_face = "sad"
		"happy":
			match GlobalVariables.current_mod:
				"bocchi":
					texture = bocchi_happy
				"nijika":
					if texture == nijika_sad:
						texture = nijika_happy_1
			current_face = "happy"

			
	
		
			
