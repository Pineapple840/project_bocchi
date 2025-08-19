extends Node2D

var current_level_name = "WASURETE_YARANAI"

var video_start_time = 0

var level_info = {
	"WASURETE_YARANAI" = {
		"bpm": 184.0,
		"offset": 0.722,
		"note_list": [
			#Info for each note:
			#1st value - what measure each note is on
			#2nd value - angle (in degrees) from previous note
			#3rd value - key required to press
			#4th value (optional) - If part of a multi note, jump distance modifier
[1, 180, 'J'], [1.5, 180, 'F'], [2, 180, 'J'], [3, 180, 'J'], [3.5, 45, 'J'], [4.5, 45, 'F'], 
[5.5, 45, 'J'], [6.5, 45, 'F'], [7.5, 0, 'D'], [8, 0, 'D'], [8.5, 0, 'D'],
[9, 0, 'J'], [9.5, 0, 'F'], [10, 0, 'J'], [11, 0, 'J'], [11.5, 0, 'J'], [12.5, 0, 'F'],
[13.5, -90, 'J'], [14, -90, 'J'], [14.5, -90, 'F'],

[17, 180, 'D'], [17.5, 180, 'K'], [18, 180, 'D'], [19, 180, 'D'], [19.5, 180, 'D'], [20.5, 180, 'K'], 
[21.5, 90, 'D'], [22.5, 90, 'K'], [23.5, 180, 'J'], [24, 180, 'J'], [24.5, 180, 'J'],
[25, 180, 'D'], [25.5, 180, 'K'], [26, 180, 'D'], [27, 180, 'D'], [27.5, 180, 'D'], [28.5, 180, 'K'],
[29.5, -90, 'D'], [30, -90, 'D'], [30.5, -90, 'K'],

[33, 0, 'D'], [33.5, 20, 'F'], [34, 20, 'D'], [34.5, 20, 'F'], [35, 20, 'D'], [35.5, 20, 'F'], [36, 20, 'J'],
[37, -90, 'F'], [37.5, 20, 'J'], [38, 20, 'F'], [38.5, 20, 'J'], [39, 20, 'F'], [39.5, 20, 'J'], [40, 20, 'D'], [40.5, 20, 'K'],
[41, -90, 'J'], [41.5, 20, 'K'], [42, 20, 'J'], [42.5, 20, 'K'], [43, 20, 'J'], [43.5, 20, 'K'], [44, 20, 'F'], [44.5, 20, 'D'],
[45, -90, 'K'], [45.5, 20, 'J'], [46.5, -90, 'D'], [47.5, -90, 'K'], [48, -90, 'J'], [48.5, -90, 'K'],

[50, 180, 'K'], [50.5, -135, 'J'], [51, -135, 'F'], [51.5, 180, 'F'], [52, -135, 'D'], [52.5, -135, 'D'],
[53.5, 180, 'D'], [54 , 180, 'D'], [55.5 , 180, 'J'], [56 , 180, 'K'], [56.5 , 180, 'J'],
[57 , 180, 'J'], [57.5 , 180, 'J'], [57.75 , 180, 'F'], [58 , 180, 'J'], [58.5 , 180, 'J'], [59.5 , 90, 'J'], [60.5 , 90, 'K'],
[61.5, 180, 'F'], [62, 180, 'F'], [62.5, 180, 'F'], [63.5, 90, 'D'], [64, 90, 'D'], [64.5, 90, 'D'],

[65.5, 0, 'J',], [66, 0, 'K',], [66.5, 0, 'F',], [67, 0, 'F',], [68, 0, 'K',], [68.5, 0, 'J',],
[69, -20, 'F',], [70, -20, 'J',], [71, 40, 'D',], [72, 0, 'K',],
[73.5, -135, 'F',], [74, -135, 'F',], [74.5, -135, 'F',], [75, -135, 'J',], [75.5, -135, 'D',], [76, -135, 'J',], [76.5, -135, 'D'],
[77, -160, 'K',], [78, -160, 'J',], [79, 140, 'F',], [80, 180, 'D',],

[81.5, 45, 'D'], [82, 45, 'F'], [82.5, 45, 'J'], [83.5, 0, 'J'], [84, 45, 'F'], [84.5, 45, 'D'],
[85, -70, 'K',], [86, -70, 'D',], [87, -130, 'J',], [88, -90, 'F',],
[89, 180, 'K'], [89.5, 180, 'K'], [90, 180, 'K'], [90.5, 150, 'J'], [91, -150, 'K'],
[93, 90, 'D'], [93.5, 90, 'F'], [94, 90, 'J'], [94.5, 90, 'K'], [95.5, 90, 'K'],

[97.5, 0, 'F'], [98, 0, 'D'], [98.5, 0, 'D'], [99, 0, 'K'], [99.5, 0, 'K'], [100, 0, 'D'], [100.5, 0, 'D'],
[101, 30, 'F', 0.5], [101, -90, 'J', 0.5], [102, 0, 'J', 0.5], [102, -90, 'K', 0.5], [103, 45, 'J', 0.7071], [103, 90, 'F', 0.5], [104, -45, 'J', 0.7071], [104, -90, 'K', 0.5],
[105.5, 30, 'D'], [106, 0, 'D'], [106.5, 0, 'F'], [107, 0, 'D'], [108, -90, 'F'], [108.5, 180, 'D'],
[109, -150, 'K', 0.5], [109, 90, 'J', 0.5], [110, 180, 'J', 0.5], [110, 90, 'F', 0.5], [111, 180, 'F', 0.5], [111, 90, 'D', 0.5], [112, 180, 'D', 0.5], [112, -90, 'F', 0.5],

[113.5, 180, 'J'], [114, 180, 'K'], [114.5, 180, 'K'], [115, 180, 'D'], [115.5, 180, 'D'], [116, 180, 'K'], [116.5, 180, 'K'],
[117, 180, 'F'], [118, -90, 'J'], [119, -90, 'D'], [120, -90, 'K'],
[121, 180, 'F'], [122, 180, 'J'], [124, 150, 'F'], [124.5, 150, 'D'],
[125, -150, 'F'], [125.5, -90, 'J'], [126, -90, 'K'], [127, -30, 'K'], [128.5, 60, 'D'],

[129.5, -30, 'J'], [130, 0, 'J'], [130.5, 0, 'J'], [131, 0, 'J'], [131.5, 30, 'F'], [132, 0, 'D'], [132.5, -60, 'K'],
[133.5, 30, 'K'], [134, 30 , 'K'], [134.5, 60, 'J'], [135, 150, 'J'], [135.5, 120, 'F'], [136, 30, 'F'] 
   
]
	}
}

func _ready():
	
	Signals.PlayVideoConnected.connect(PlayVideoConnected)
	
	var note_list = level_info.get(current_level_name).get("note_list")
	#var fk_times_arr = str_to_var(fk_times)
	var offset = level_info.get(current_level_name).get("offset")
	var bpm = level_info.get(current_level_name).get("bpm")
	var seconds_per_beat: float = 60/bpm
	

	
	var last_x: float = 0
	var last_y: float = 0
	var last_beat: float = 1
	var jump_distance = 80
		
	var button_name: String = ""
	for note in note_list:
		
		var jump_for_note = jump_distance
		
		var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
		
		
		match note[2]:
			'D':
				button_name = "button_D"
			'F':
				button_name = "button_F"
			'J':
				button_name = "button_J"
			'K':
				button_name = "button_K"
			
		#if note[0] != 0 and note[0] > video_start_time:
			
		#for multi notes
		var real_delay: float = (note[0] + 4) * seconds_per_beat + offset - 1.375 - time_delay - video_start_time
		var time_since_last_beat = note[0] - last_beat
		
		var is_multi_note: bool = false
		
		if note.size() == 4:
			time_since_last_beat = note[3]
			is_multi_note = true
		
		var x_pos = last_x + jump_for_note * cos((note[1] * PI) / 180) * time_since_last_beat
		var y_pos = last_y + jump_for_note * sin((note[1] * PI) / 180) * time_since_last_beat
		
		last_x = x_pos
		last_y = y_pos
		last_beat = note[0]
		if note[0] != 0 and real_delay > 0:
			
			SpawnFallingKey(button_name, real_delay, x_pos, y_pos, is_multi_note)
		
			
	
	
func SpawnFallingKey(button_name: String, real_delay: float, x_pos: float, y_pos: float, is_multi_note: bool):
	await get_tree().create_timer(real_delay).timeout
	Signals.CreateFallingKey.emit(button_name, x_pos, y_pos, is_multi_note)

func PlayVideo(video_start_time):
	Signals.PlayVideo.emit(video_start_time)
	
func PlayVideoConnected():
	PlayVideo(video_start_time)
	
