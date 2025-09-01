extends Node2D

var current_level_name = "WASURETE_YARANAI"

var video_start_time = 0
var current_seconds_per_beat: float
var current_offset: float
var current_jump_distance: float

var level_info = {
	"WASURETE_YARANAI" = {
		"bpm": 184.0,
		"offset": 0.722,
		"default_jump_distance": 80.0,
		"note_list": [
			#Info for each note:
			#1st value - What beat each note is on (each line is a measure)
			#2nd value - Angle (in degrees) from previous note
			#3rd value - Key required to press
			
			#4th value (optional) - If part of a multi note, jump distance modifier. 
				#If it is a hold note a but not a multi note value is 'N',
			
			#5th value (optional) - If part of a hold note
			#6th value (optional) - Angle (in degrees) of ghost note from hold note
			#7th value (optional) - how many measures the hold lasts for
			 
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
[101, 30, 'F', 0.5, 'M'], [101, -90, 'J', 0.5, 'M'], [102, 0, 'J', 0.5, 'M'], [102, -90, 'K', 0.5, 'M'], [103, 45, 'J', 0.7071, 'M'], [103, 90, 'F', 0.5, 'M'], [104, -45, 'J', 0.7071, 'M'], [104, -90, 'K', 0.5, 'M'],
[105.5, 30, 'D'], [106, 0, 'D'], [106.5, 0, 'F'], [107, 0, 'D'], [108, -90, 'F'], [108.5, 180, 'D'],
[109, -150, 'K', 0.5, 'M'], [109, 90, 'J', 0.5, 'M'], [110, 180, 'J', 0.5, 'M'], [110, 90, 'F', 0.5, 'M'], [111, 180, 'F', 0.5, 'M'], [111, 90, 'D', 0.5, 'M'], [112, 180, 'D', 0.5, 'M'], [112, -90, 'F', 0.5, 'M'],

[113.5, 180, 'J'], [114, 180, 'K'], [114.5, 180, 'K'], [115, 180, 'D'], [115.5, 180, 'D'], [116, 180, 'K'], [116.5, 180, 'K'],
[117, 180, 'F'], [118, -90, 'J'], [119, -90, 'D'], [120, -90, 'K'],
[121, 180, 'F'], [122, 180, 'J'], [124, 150, 'F'], [124.5, 150, 'D'],
[125, -150, 'F'], [125.5, -90, 'J'], [126, -90, 'K'], [127, -30, 'K'], [128.5, 60, 'D', 1.5, 'M'], [128.5, -90, 'F', 0.5, 'M'],

[129.5, -30, 'J'], [130, 0, 'J'], [130.5, 0, 'J'], [131, 0, 'J'], [131.5, 30, 'F'], [132, 0, 'D'], [132.5, -30, 'F', 1, 'M'], [132.5, -90, 'K', 1, 'M'],
[133.5, 30, 'J'], [134, 30 , 'J'], [134.5, 60, 'F'], [135, 150, 'F'], [135.5, 120, 'D'], [136, 30, 'D'],
[137.5, 150, 'F'], [138, -150, 'J'], [138.5, -150, 'K'], [139, -110, 'F'], [139.5, -110, 'J'], [140, -70, 'F'], [140.5, -70, 'J'],
[141, -30, 'F', 0.5, 'M'], [141, -90, 'J', 0.5, 'M'], [141, -90, 'K', 0.5, 'M'], [142, 0, 'K', 1, 'M'], [142, 90, 'J', 0.5, 'M'], [142, 90, 'F', 0.5, 'M'], [143, 0, 'F', 1, 'M'], [143, -90, 'J', 0.5, 'M'], [143, -90, 'K', 0.5, 'M'], [144, 0, 'K', 1, 'M'], [144, 90, 'J', 0.5, 'M'], [144, 90, 'F', 0.5, 'M'],
 
[145, 30, 'D', 1], [145, 0, 'F', 0.5], [147, 30, 'J'], [148, 30, 'F'],
[150, 90, 'K'], [151, 180, 'J'], [152, 180, 'K'],
[153, -150, 'D'], [154.5, -150, 'K'], [155, -150, 'K'], [156, -150, 'J'],
[157, -60, 'K'], [157.5, -60, 'K'], [158, -60, 'K'], [158.5, -30, 'J'] , [159, -60, 'K'],

[161, -150, 'F', 'N', 'H', 90, 2], [163, 180, 'J', 'N', 'H', 90, 2],
[165, 180, 'K', 'N', 'H', 90, 2], [167, 180, 'J', 'N', 'H', 90, 2],
[169, 120, 'K'], [170, 120, 'J'], [171, 90, 'F'], [172, 90, 'D'],
[173, 90, 'F', 'N', 'H', 0, 2], [175, 30, 'D'],

[177, -30, 'J', 'N', 'H', -90, 2], [179, 0, 'F', 'N', 'H', -90, 2],
[181, 0, 'D', 'N', 'H', -90, 2], [183, 0, 'F', 'N', 'H', -90, 2],
[185, -60, 'D'], [186, -60, 'K'], [187, -90, 'J'], [188, -90, 'F'],
[189, 180, 'J', 'N', 'H', 180, 2], [191, -150, 'K'], 

[193, 180, 'F'], [194, 170, 'F'], [194.5, 165, 'F'], [195.5, 155, 'F'], [196.5, 145, 'D'],
[197.5, 135, 'D'], [198, 130, 'J'], [198.5, 125, 'F'], [199, 120, 'D'],
[201, 30, 'F'], [202, 50, 'F'], [202.5, 45, 'F'], [203.5, 35, 'F'], [204, 30, 'K'], [204.5, 25, 'J'],
[205.5, 15, 'D'], [206, 10, 'F'], [206.5, 5, 'J'], [207, 0, 'F'], [208, 0, 'D'],

[209, -30, 'K', 'N', 'H', 0, 2], [211, -90, 'J', 'N', 'H', 180, 2],
[213, 90, 'K', 'N', 'H', 0, 2], [215, -90, 'D', 'N', 'H', 180, 5], [216, -90, 'F', 'N', 'H', 180, 4],
[220, -150, 'J'],
[221, 0, 'K'], [222, 0, 'J'], [223, 0, 'D'], [224, 0, 'J']

 
   
]
	}
}

var note_list = level_info.get(current_level_name).get("note_list")
#var fk_times_arr = str_to_var(fk_times)
var offset = level_info.get(current_level_name).get("offset")
var bpm = level_info.get(current_level_name).get("bpm")
var seconds_per_beat: float = 60/bpm
var jump_distance = level_info.get(current_level_name).get("default_jump_distance")




	
func _ready():
	
	Signals.PlayVideoConnected.connect(PlayVideoConnected)
	Signals.VideoStarted.connect(VideoStarted)
	
	
	current_seconds_per_beat = seconds_per_beat
	current_offset = offset
	current_jump_distance = jump_distance
	


	
	
func SpawnFallingKey(button_name: String, real_delay: float, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2):
	await get_tree().create_timer(real_delay).timeout
	Signals.CreateFallingKey.emit(button_name, x_pos, y_pos, is_multi_note, is_hold_note, ghost_pos)

func PlayVideo():
	Signals.PlayVideo.emit(video_start_time, current_seconds_per_beat, current_offset, current_jump_distance)
	
func PlayVideoConnected():
	PlayVideo()
	
func VideoStarted():

	

	
	var last_x: float = 0
	var last_y: float = 0
	var last_beat: float = 1
	
	
	
		
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
		var real_delay: float = (note[0] + 4) * seconds_per_beat + offset - 1.435 - time_delay - video_start_time
		var time_since_last_beat = note[0] - last_beat
		
		var is_multi_note: bool = false
		var is_hold_note: bool = false
		
		if note.size() >= 4:
			if str(note[3]) != 'N':
				time_since_last_beat = note[3]
				
				
		
		var x_pos = last_x + jump_for_note * cos((note[1] * PI) / 180) * time_since_last_beat
		var y_pos = last_y + jump_for_note * sin((note[1] * PI) / 180) * time_since_last_beat
		
		var ghost_pos: Vector2 = Vector2(0, 0)
		
		if note.size() >= 5:
			
			if str(note[4]) == 'M' or str(note[4]) == 'MH':
				is_multi_note = true
				
			if str(note[4]) == 'H' or str(note[4]) == 'MH':
				is_hold_note = true
				ghost_pos = Vector2(note[6] * cos((note[5] * PI / 180)) * jump_for_note, note[6] * sin((note[5]) * PI / 180) * jump_for_note)
				print(ghost_pos)
		
		last_x = x_pos
		last_y = y_pos
		last_beat = note[0]
		if note[0] != 0 and real_delay > 0:
			
			SpawnFallingKey(button_name, real_delay, x_pos, y_pos, is_multi_note, is_hold_note, ghost_pos)
	
