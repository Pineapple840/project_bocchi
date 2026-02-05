"""Responsible for handling input and spawning notes, which are added and removed from a queue."""

extends Sprite2D

@onready var falling_key = preload("res://objects/spawned_key.tscn")
@onready var hold_ghost_key = preload("res://objects/hold_ghost_key.tscn")
@onready var score_text = preload("res://objects/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = []
var ghost_key_queue = []

var pefect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80

var pefect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

var current_held_note: Sprite2D
var ghost_key_to_pop: Sprite2D
var in_hold_state: bool

var song_seconds_per_beat: float
var song_jump_distance: float


func _ready():
	Signals.CreateFallingKey.connect(CreateFallingKey)
	Signals.KillGhost.connect(KillGhost)
	
	Signals.LevelStart.connect(LevelStart)
	Signals.PlayVideoConnected.emit()
	

func _process(delta):
	
	
	if falling_key_queue.size() > 0 or in_hold_state:
		
		var score_text_value: String = ""
		
		if not in_hold_state:
			if falling_key_queue.front().has_passed:
				var key_to_pop = falling_key_queue.pop_front()
				
				score_text_value = "X"
				Signals.IncrementScore.emit(0)
				Signals.ResetCombo.emit()
				KillKey(key_to_pop)
				
				var st_inst = score_text.instantiate()
				get_tree().get_root().call_deferred("add_child", st_inst)
				st_inst.SetTextInfo(score_text_value)
				st_inst.global_position = key_to_pop.global_position
				
				
			
			
		if Input.is_action_just_pressed(key_name):
			if falling_key_queue.size() > 0:
				
				var key_to_pop = falling_key_queue.pop_front()
				
				#measured in ms
				var real_rotate_time = (1000 / key_to_pop.rotate_speed) * key_to_pop.rotating_arrow.global_rotation_degrees
				
				
				if key_to_pop != null:
					if key_to_pop.note_type == "hold" and key_to_pop.rotating_arrow.global_rotation_degrees > -50:
						key_to_pop.move_to_ghost()
						var ghost_distance = key_to_pop.abs_ghost_distance
						var teleport: Vector2 = (((key_to_pop.seconds_per_degree * key_to_pop.rotating_arrow.global_rotation_degrees) / ((ghost_distance / song_jump_distance) * song_seconds_per_beat)) * ghost_distance * key_to_pop.ghost_offset_position.normalized())
						print("teleport" + str(teleport) + " " + str(key_to_pop.seconds_per_degree) + " " + str(song_seconds_per_beat)) 
						key_to_pop.note_object.position += (teleport)
						key_to_pop.rotating_arrow.visible = false
						current_held_note = key_to_pop
						in_hold_state = true
					else:
						in_hold_state = false
			
					#var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
					print("Note" + key_name + " hit at " + str(real_rotate_time) + " ms")
					
					#Perfect hit
					if abs(real_rotate_time) < 55:
						Signals.IncrementScore.emit(300)
						Signals.IncrementCombo.emit()
						Signals.SetTimingLabel.emit(real_rotate_time)
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "300"
						
						
					#Great hit
					elif abs(real_rotate_time) < 110:
						Signals.IncrementScore.emit(100)
						Signals.IncrementCombo.emit()
						Signals.SetTimingLabel.emit(real_rotate_time)
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "100"
					
					#OK hit
					elif abs(real_rotate_time) < 165:
						Signals.IncrementScore.emit(100)
						Signals.IncrementCombo.emit()
						Signals.SetTimingLabel.emit(real_rotate_time)
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "50"
						
					#Miss
					elif real_rotate_time > -344:
						Signals.IncrementScore.emit(0)
						Signals.ResetCombo.emit()
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "X"
						
					#Nothing happens if the note is out of range (>50 degrees early). Pushed back onto the queue
					else:
						falling_key_queue.push_front(key_to_pop)
						
					var st_inst = score_text.instantiate()
					get_tree().get_root().call_deferred("add_child", st_inst)
					st_inst.SetTextInfo(score_text_value)
					st_inst.global_position = key_to_pop.note_object.global_position
					
					
		if Input.is_action_just_released(key_name):
			if in_hold_state and current_held_note != null:
				var distance_from_ghost = current_held_note.note_object.position - current_held_note.ghost_offset_position
				var dotted_distance = distance_from_ghost.dot(current_held_note.ghost_offset_position.normalized())
				
				#measured in ms
				var real_move_time = (1000 / current_held_note.move_speed) * dotted_distance
				print("note " + key_name + " released at " + str(real_move_time) + "ms")
				
				
				if abs(dotted_distance) <= 60:
					Signals.IncrementScore.emit(300)
					Signals.IncrementCombo.emit()
					Signals.SetTimingLabel.emit(real_move_time)
					score_text_value = "300"
					
				elif abs(dotted_distance) <= 110:
					Signals.IncrementScore.emit(100)
					Signals.IncrementCombo.emit()
					Signals.SetTimingLabel.emit(real_move_time)
					score_text_value = "100"
				
				elif abs(dotted_distance) <= 140:
					Signals.IncrementScore.emit(50)
					Signals.IncrementCombo.emit()
					Signals.SetTimingLabel.emit(real_move_time)
					score_text_value = "50"
				
				else:
					Signals.IncrementScore.emit(0)
					Signals.ResetCombo.emit()
					score_text_value = "X"
					
				KillKey(current_held_note)
				var st_inst = score_text.instantiate()
				get_tree().get_root().call_deferred("add_child", st_inst)
				st_inst.SetTextInfo(score_text_value)
				st_inst.global_position = current_held_note.global_position
				
				#if ghost_key_queue.size() > 0:
					#KillGhost(key_name)
				
				in_hold_state = false
		


func CreateFallingKey(button_name: String, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(key_name, x_pos, y_pos, is_multi_note, is_hold_note, ghost_pos)
		
		if is_hold_note:
			var hold_ghost_key_inst = hold_ghost_key.instantiate()
			fk_inst.call_deferred("add_child", hold_ghost_key_inst)
			
			#ghost_pos = fk_inst.position + ghost_pos
			hold_ghost_key_inst.Setup(key_name, ghost_pos)
			
			ghost_key_queue.push_back(hold_ghost_key_inst)
			
		
		falling_key_queue.push_back(fk_inst)
		
func KillGhost(button_name: String):
	if ghost_key_queue.size() > 0 and button_name == key_name:
		ghost_key_to_pop = ghost_key_queue.pop_front()
		ghost_key_to_pop.queue_free()
		
func KillKey(key_to_pop):
	if key_to_pop.note_type == "hold":
		KillGhost(key_name)
	key_to_pop.queue_free()
		
func LevelStart(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float):
	song_seconds_per_beat = seconds_per_beat
	song_jump_distance = jump_distance
	
		
