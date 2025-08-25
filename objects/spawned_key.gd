extends Sprite2D

@export var rotate_speed: float = 0.93
@export var arrow_opacity = 0.3

@onready var rotating_arrow: Sprite2D = $Sprite2D
var hold_ghost_key

var moving_to_ghost: bool = false

#true if falling key has passed the allowed input frame

var half_pass = false
var has_passed: bool = false
var pass_threshold = 30
var note_type = "normal"

var bocchi_colour = Color(1, 0.6, 0.8, 1)
var nijika_colour = Color(1, 1, 0.4, 1)
var ryo_colour = Color(0.5, 0.5, 1, 1)
var kita_colour = Color(1, 0.5, 0.5, 1)

func _init():
	set_process(false)
	hold_ghost_key = preload("res://objects/hold_ghost_key.tscn")
	
func _process(delta):
	$Sprite2D.global_rotation_degrees += rotate_speed * 165 * delta
	
	if $Sprite2D.global_rotation_degrees < -170:
		half_pass = true
	
	
	if $Sprite2D.global_rotation_degrees > pass_threshold and half_pass and not moving_to_ghost:
		#print($Timer.wait_time - $Timer.time_left)
		has_passed = true
		visible = false
		
	if moving_to_ghost:
		position += Vector2(0, 214.67 * delta)
		
	

func Setup(target_x: float, target_frame: int, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2):
	
	global_position = Vector2(x_pos, y_pos)
	$Sprite2D.global_rotation_degrees = -175
	
	$Sprite2D.modulate = Color(1, 1, 1, arrow_opacity)
	
	
	
	match target_frame:
		0:
			$KeyIndicator.add_theme_color_override("default_color", ryo_colour)
			$KeyIndicator.text = "[center]" + "D"
		1:
			$KeyIndicator.add_theme_color_override("default_color", nijika_colour)
			$KeyIndicator.text = "[center]" + "F"
		2:
			$KeyIndicator.add_theme_color_override("default_color", kita_colour)
			$KeyIndicator.text = "[center]" + "J"
		3:
			$KeyIndicator.add_theme_color_override("default_color", bocchi_colour)
			$KeyIndicator.text = "[center]" + "K"
	
	#fade_in()
	
	if is_multi_note:
		$KeyIndicator.add_theme_color_override("font_outline_color", Color(0, 0.8, 0, 1))
	
	if is_hold_note:
		note_type = "hold"
		$HoldIndicator.visible = true
		
	else:
		$HoldIndicator.visible = false
	
	set_process(true)
	
func move_to_ghost():
	moving_to_ghost = true
	

	
