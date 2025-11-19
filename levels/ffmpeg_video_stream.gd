extends Control

@onready var video_player = get_node("VideoStreamPlayer2")
@onready var background_dim_object = get_node("BackgroundDim")

var script_video_start_time: float

var background_dim_value: float
var time_elapsed: float = 0
var done = false

func _ready():
	Signals.PlayVideo.connect(PlayVideo)
	Signals.PlayVideoConnected.emit()
	
	ReadBackgroundDim()
	

func PlayVideo(video_resource: String, video_start_time: float):
	var stream = FFmpegVideoStream.new()
	stream.set_file(video_resource)
	
	if GlobalVariables.current_song_name == "never_forget":
		video_player.volume_db = 10
	elif GlobalVariables.current_song_name == "seishun_complex":
		video_player.volume_db = 10
	else:
		video_player.volume_db = 0

	
	video_player.stream = stream
	script_video_start_time = video_start_time
	#video_player.playback_speed = 2.0
	video_player.play()
	video_player.set_stream_position(video_start_time)
	print(video_player.get_stream_position())
	#await(video_s == true)
	#print(video_player.get_stream_position())
	#Signals.VideoStarted.emit()
	
func SetBackgroundDim(value: float):
	var alpha = value / 100
	background_dim_object.color = Color(0, 0, 0, alpha)
	

	
func _process(delta):
	if video_player.get_stream_position() > script_video_start_time + 0.0001 and not done:
		#set_process(false)
		done = true
		print("position when videostarted emitted" + str(video_player.get_stream_position()))
		Signals.VideoStarted.emit()
		
	time_elapsed += delta
	Signals.SendVideoDesync.emit(video_player.get_stream_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() - time_elapsed)
		
func ReadBackgroundDim():
	if FileAccess.file_exists("user://game_settings.json"):
		var file = FileAccess.open("user://game_settings.json", FileAccess.READ)
		var json = file.get_as_text()
		var options_data = JSON.parse_string(json)
		background_dim_value = options_data["background_dim"]
		
		file.close()
		
		SetBackgroundDim(background_dim_value)
