extends Control

@onready var video_player = get_node("VideoStreamPlayer2")

func _ready():
	var stream = FFmpegVideoStream.new()
	stream.set_file("res://videos/wasurete_yaranai.mp4")

	
	video_player.stream = stream
	#video_player.playback_speed = 2.0
	video_player.play()
	#video_player.set_stream_position(20)
