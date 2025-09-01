extends Control

@onready var video_player = get_node("VideoStreamPlayer2")
var script_video_start_time: float

var run_once = false

func _ready():
	Signals.PlayVideo.connect(PlayVideo)
	Signals.PlayVideoConnected.emit()
	

func PlayVideo(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float):
	var stream = FFmpegVideoStream.new()
	stream.set_file("res://videos/wasurete_yaranai.mp4")

	
	video_player.stream = stream
	script_video_start_time = video_start_time
	#video_player.playback_speed = 2.0
	video_player.play()
	video_player.set_stream_position(video_start_time)
	print(video_player.get_stream_position())
	#await(video_s == true)
	#print(video_player.get_stream_position())
	#Signals.VideoStarted.emit()
	
func _process(delta):
	if video_player.get_stream_position() > script_video_start_time + 0.0001 and not run_once:
		run_once = true
		print(video_player.get_stream_position())
		Signals.VideoStarted.emit()
