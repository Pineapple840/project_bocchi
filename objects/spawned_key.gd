"""Script for the instantiated note"""

extends Sprite2D

# rotate speed/move speed in units/degrees per second
@export var rotate_speed: float = 153.45
@export var move_speed: float = 245.33
var seconds_per_degree: float


@export var arrow_opacity = 0.3

@onready var note_object: Sprite2D = $NoteObject
@onready var rotating_arrow: Sprite2D = $NoteObject/Sprite2D
@onready var animation_player: AnimationPlayer = %AnimationPlayer


var hold_ghost_key

var moving_to_ghost: bool = false

#true if falling key has passed the allowed input frame

var button_name: String

var half_pass: bool = false
var has_passed: bool = false
var pass_threshold: int = 30

var note_type: String = "normal"

var ghost_offset_position: Vector2
var original_position: Vector2
var passed_ghost: bool
var abs_ghost_distance: float

var bocchi_colour = Color(1, 0.6, 0.8, 1)
var nijika_colour = Color(1, 1, 0.4, 1)
var ryo_colour = Color(0.5, 0.5, 1, 1)
var kita_colour = Color(1, 0.5, 0.5, 1)

func _init():
	
	
	
	hold_ghost_key = preload("res://objects/hold_ghost_key.tscn")
	
func _process(delta):
	seconds_per_degree = 1 / (rotate_speed)
	
	$NoteObject/Sprite2D.global_rotation_degrees += rotate_speed * delta
	
	if $NoteObject/Sprite2D.global_rotation_degrees < -170:
		half_pass = true
	
	
	if $NoteObject/Sprite2D.global_rotation_degrees > pass_threshold and half_pass and not moving_to_ghost:
		#print($Timer.wait_time - $Timer.time_left)
		has_passed = true
		visible = false
		
		
	if moving_to_ghost:
		var normalised_ghost_pos = ghost_offset_position.normalized()
		%NoteObject.position += move_speed * delta * normalised_ghost_pos
		
	if position.distance_to(ghost_offset_position + original_position) < 5 and note_type == "hold":
		passed_ghost = true
		
	if position.distance_to(ghost_offset_position + original_position) > 50 and note_type == "hold" and passed_ghost:
		Signals.KillGhost.emit(button_name)
		queue_free()
		
	

func Setup(key_name: String, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2):
	
	
	global_position = Vector2(x_pos, y_pos)
	original_position = global_position
	$NoteObject/Sprite2D.global_rotation_degrees = -175
	
	$NoteObject/Sprite2D.modulate = Color(1, 1, 1, arrow_opacity)
	
	ghost_offset_position = ghost_pos
	abs_ghost_distance = Vector2(0, 0).distance_to(ghost_offset_position)
	
	match GlobalVariables.current_mod:
		"bocchi":
			%AnimationPlayer.autoplay = "fade_in"
		"nijika":
			%AnimationPlayer.autoplay = "sudden_mod"
		"ryo":
			%AnimationPlayer.autoplay = "hidden_mod"
		"kita":
			%AnimationPlayer.autoplay = "fade_in"
	button_name = key_name
	
	match key_name:
		"button_D":
			$NoteObject/KeyIndicator.add_theme_color_override("default_color", ryo_colour)
			$NoteObject/KeyIndicator.text = "[center]" + "D"
		"button_F":
			$NoteObject/KeyIndicator.add_theme_color_override("default_color", nijika_colour)
			$NoteObject/KeyIndicator.text = "[center]" + "F"
		"button_J":
			$NoteObject/KeyIndicator.add_theme_color_override("default_color", kita_colour)
			$NoteObject/KeyIndicator.text = "[center]" + "J"
		"button_K":
			$NoteObject/KeyIndicator.add_theme_color_override("default_color", bocchi_colour)
			$NoteObject/KeyIndicator.text = "[center]" + "K"
	
	#fade_in()
	
	if is_multi_note:
		$NoteObject/KeyIndicator.add_theme_color_override("font_outline_color", Color(0, 0.8, 0, 1))
	
	if is_hold_note:
		note_type = "hold"
		$NoteObject/HoldIndicator.visible = true
		
	else:
		$NoteObject/HoldIndicator.visible = false
	
	set_process(true)
	
func move_to_ghost():
	moving_to_ghost = true
	

	
