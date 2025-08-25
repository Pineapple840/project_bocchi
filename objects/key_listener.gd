extends Sprite2D

@onready var falling_key = preload("res://objects/spawned_key.tscn")
@onready var hold_ghost_key = preload("res://objects/hold_ghost_key.tscn")
@onready var score_text = preload("res://objects/score_press_text.tscn")
@export var key_name: String = ""

var falling_key_queue = []

var pefect_press_threshold: float = 30
var great_press_threshold: float = 50
var good_press_threshold: float = 60
var ok_press_threshold: float = 80

var pefect_press_score: float = 250
var great_press_score: float = 100
var good_press_score: float = 50
var ok_press_score: float = 20

var current_held_note
var hold: bool

func _ready():
	Signals.CreateFallingKey.connect(CreateFallingKey)

func _process(delta):
	
	
	if falling_key_queue.size() > 0 or hold:
		
		var score_text_value: String = ""
		
		if not hold:
			if falling_key_queue.front().has_passed:
				var key_to_pop = falling_key_queue.pop_front()
				
				score_text_value = "X"
				Signals.IncrementScore.emit(0)
				Signals.ResetCombo.emit()
				if key_to_pop.note_type != "hold":
					key_to_pop.queue_free()
				
				var st_inst = score_text.instantiate()
				get_tree().get_root().call_deferred("add_child", st_inst)
				st_inst.SetTextInfo(score_text_value)
				st_inst.global_position = key_to_pop.global_position
			
			
		if Input.is_action_just_pressed(key_name):
			if falling_key_queue.size() > 0:
				
				var key_to_pop = falling_key_queue.pop_front()
				
				if key_to_pop != null:
					if key_to_pop.note_type == "hold":
						key_to_pop.move_to_ghost()
						current_held_note = key_to_pop
						hold = true
					else:
						hold = false
			
					var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
					print("Note hit at " + str(key_to_pop.rotating_arrow.global_rotation_degrees) + " degrees")
					
					#Perfect hit
					if abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 8:
						Signals.IncrementScore.emit(300)
						Signals.IncrementCombo.emit()
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "300"
						
					#Great hit
					elif abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 16:
						Signals.IncrementScore.emit(100)
						Signals.IncrementCombo.emit()
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "100"
					
					#OK hit
					elif abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 24:
						Signals.IncrementScore.emit(100)
						Signals.IncrementCombo.emit()
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "50"
						
					#Miss
					elif key_to_pop.rotating_arrow.global_rotation_degrees > -50:
						Signals.ResetCombo.emit()
						if key_to_pop.note_type != "hold":
							key_to_pop.queue_free()
						score_text_value = "X"
						Signals.IncrementScore.emit(0)
						
					#Nothing happens if the note is out of range (>50 degrees early). Pushed back onto the queue
					else:
						falling_key_queue.push_front(key_to_pop)
						
					var st_inst = score_text.instantiate()
					get_tree().get_root().call_deferred("add_child", st_inst)
					st_inst.SetTextInfo(score_text_value)
					st_inst.global_position = key_to_pop.global_position
					
			if Input.is_action_just_released(key_name):
				if hold and current_held_note != null:
					print("noce")
					current_held_note.queue_free()
		


func CreateFallingKey(button_name: String, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, int(frame), x_pos, y_pos, is_multi_note, is_hold_note, ghost_pos)
		
		if is_hold_note:
			var hold_ghost_key_inst = hold_ghost_key.instantiate()
			get_tree().get_root().call_deferred("add_child", hold_ghost_key_inst)
			ghost_pos = fk_inst.position + ghost_pos
			hold_ghost_key_inst.Setup(ghost_pos)
		
		falling_key_queue.push_back(fk_inst)
