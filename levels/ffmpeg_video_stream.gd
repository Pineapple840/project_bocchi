extends Control

@onready var video_player = get_node("VideoStreamPlayer2")

var video_s = false

func _ready():
	Signals.PlayVideo.connect(PlayVideo)
	Signals.PlayVideoConnected.emit()
	

func PlayVideo(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float):
	print("video pay")
	var stream = FFmpegVideoStream.new()
	stream.set_file("res://videos/wasurete_yaranai.mp4")

	
	video_player.stream = stream
	#video_player.playback_speed = 2.0
	video_player.play()
	video_player.set_stream_position(video_start_time)
	print(video_player.get_stream_position())
	#await(video_s == true)
	#print(video_player.get_stream_position())
	#Signals.VideoStarted.emit()
	
func _process(delta):
	if video_player.get_stream_position() > 5 and not video_s:
		video_s = false
		print(video_player.get_stream_position())
		Signals.VideoStarted.emit()
