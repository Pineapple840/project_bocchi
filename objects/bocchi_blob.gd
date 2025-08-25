extends Sprite2D

var del = 1
var animation: bool = false
var current_face = "happy"
var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()

func _ready():
	
	Signals.ChangeBocchiBlobFace.connect(ChangeBocchiBlobFace)
	Signals.PlayVideo.connect(PlayVideo)
	
	var beat_counter = 0

	
	bounce(0.7013478261 + time_delay)
	
func bounce(delay):
	await get_tree().create_timer(delay).timeout
	bounce(0.3260869565)
	
	if animation:
		position.y += 5
		animation = false
	elif current_face == "happy":
		position.y -= 5
		animation = true
		
func PlayVideo(video_start_time: float):
	bounce(0.7013478261 + time_delay - fmod(video_start_time, 0.7013478261))
		
func ChangeBocchiBlobFace(face: String):
	match face:
		"sad":
			texture = load("res://art/bocchi_blob_sad.png")
			current_face = "sad"
		"happy":
			texture = load("res://art/bocchi_blob_happy.png")
			current_face = "happy"
		
			
