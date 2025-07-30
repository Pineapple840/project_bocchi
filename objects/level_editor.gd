extends Node2D

var current_level_name = "WASURETE_YARANAI"

var level_info = {
	"WASURETE_YARANAI" = {
		"bpm": 184.0,
		"offset": 0.722,
		"fk_times": [
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
]
	}
}

func _ready():
	
	var fk_times_arr = level_info.get(current_level_name).get("fk_times")
	#var fk_times_arr = str_to_var(fk_times)
	var offset = level_info.get(current_level_name).get("offset")
	var bpm = level_info.get(current_level_name).get("bpm")
	var seconds_per_beat: float = 60/bpm
	
	var time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	print(time_delay)
	
	var last_x: float = 0
	var last_y: float = 0
	var last_beat: float = 1
	var jump_distance = 80
		
	var button_name: String = ""
	for delay in fk_times_arr:
		
		match delay[2]:
			'D':
				button_name = "button_D"
			'F':
				button_name = "button_F"
			'J':
				button_name = "button_J"
			'K':
				button_name = "button_K"
			
		if delay[0] != 0:
			
			var real_delay: float = (delay[0] + 4) * seconds_per_beat + offset - 1.39 - time_delay
			var time_since_last_beat = delay[0] - last_beat
			
			var x_pos = last_x + jump_distance * cos((delay[1] * PI) / 180) * time_since_last_beat
			var y_pos = last_y + jump_distance * sin((delay[1] * PI) / 180) * time_since_last_beat
			
			last_x = x_pos
			last_y = y_pos
			last_beat = delay[0]
			
			SpawnFallingKey(button_name, real_delay, x_pos, y_pos)
		
			
	
	
func SpawnFallingKey(button_name: String, delay: float, x_pos: float, y_pos: float):
	await get_tree().create_timer(delay).timeout
	Signals.CreateFallingKey.emit(button_name, x_pos, y_pos)
	
