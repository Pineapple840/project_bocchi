extends Sprite2D

@onready var falling_key = preload("res://objects/falling_key.tscn")
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

func _ready():
	Signals.CreateFallingKey.connect(CreateFallingKey)

func _process(delta):
	
	
	if falling_key_queue.size() > 0:
		
		var score_text_value: String = ""
		
		if falling_key_queue.front().has_passed:
			var key_to_pop = falling_key_queue.pop_front()
			
			score_text_value = "X"
			Signals.ResetCombo.emit()
			
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo(score_text_value)
			st_inst.global_position = key_to_pop.global_position
			
		if Input.is_action_just_pressed(key_name):
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			print("Note hit at " + str(key_to_pop.global_rotation_degrees) + " degrees")
			
			if abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 8:
				Signals.IncrementScore.emit(300)
				Signals.IncrementCombo.emit()
				key_to_pop.queue_free()
				print("Perfect")
				score_text_value = "300"
				
			elif abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 16:
				Signals.IncrementScore.emit(100)
				Signals.IncrementCombo.emit()
				key_to_pop.queue_free()
				print("Great")
				score_text_value = "100"
				
			elif abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 32:
				Signals.IncrementScore.emit(100)
				Signals.IncrementCombo.emit()
				key_to_pop.queue_free()
				print("Ok")
				score_text_value = "50"
				
			elif abs(key_to_pop.rotating_arrow.global_rotation_degrees) < 48:
				Signals.ResetCombo.emit()
				key_to_pop.queue_free()
				print("Miss")
				score_text_value = "X"
				
			elif key_to_pop.rotating_arrow.global_rotation_degrees > 48:
				Signals.ResetCombo.emit()
				key_to_pop.queue_free()
				print("Miss")
				score_text_value = "X"
				
			else:
				print("Too early")
				falling_key_queue.push_front(key_to_pop)
				
			var st_inst = score_text.instantiate()
			get_tree().get_root().call_deferred("add_child", st_inst)
			st_inst.SetTextInfo(score_text_value)
			st_inst.global_position = key_to_pop.global_position


func CreateFallingKey(button_name: String, x_pos: float, y_pos: float):
	if button_name == key_name:
		var fk_inst = falling_key.instantiate()
		get_tree().get_root().call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, int(frame), x_pos, y_pos)
		
		falling_key_queue.push_back(fk_inst)
