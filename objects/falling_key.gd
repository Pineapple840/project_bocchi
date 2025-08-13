extends Sprite2D

@export var rotate_speed: float = 0.93

@onready var rotating_arrow: Sprite2D = $Sprite2D

var init_y_pos: float = -400

#true if falling key has passed the allowed input frame

var half_pass = false
var has_passed: bool = false
var pass_threshold = 30

func _init():
	set_process(false)
	
func fade_in():
	var tween = create_tween()
	tween.tween_property($Sprite, "modulate:a", 0, 1.0)
	tween.play()
	await tween.finished
	tween.kill()

func _process(delta):
	$Sprite2D.global_rotation_degrees += rotate_speed * 165 * delta
	
	if $Sprite2D.global_rotation_degrees < -170:
		half_pass = true
	
	
	if $Sprite2D.global_rotation_degrees > pass_threshold and half_pass and not $Timer.is_stopped():
		#print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true
		visible = false

func Setup(target_x: float, target_frame: int, x_pos: float, y_pos: float):
	
	#var random_x: float = randf_range(-400, 400)
	#var random_y: float = randf_range(-300, 100)
	
	global_position = Vector2(x_pos, y_pos)
	$Sprite2D.global_rotation_degrees = -175
	
	match target_frame:
		0:
			$Sprite2D.modulate = Color(1, 1, 1, 0.5)
			$KeyIndicator.modulate = Color(0.5, 0.5, 1, 1)
			$KeyIndicator.text = "[center]" + "D"
		1:
			$Sprite2D.modulate = Color(1, 1, 1, 0.5)
			$KeyIndicator.modulate = Color(1, 0.5, 0.8, 1)
			$KeyIndicator.text = "[center]" + "F"
		2:
			$Sprite2D.modulate = Color(1, 1, 1, 0.5)
			$KeyIndicator.modulate = Color(1, 1, 0.4, 1)
			$KeyIndicator.text = "[center]" + "J"
		3:
			$Sprite2D.modulate = Color(1, 1, 1, 0.5)
			$KeyIndicator.modulate = Color(1, 0.5, 0.5, 1)
			$KeyIndicator.text = "[center]" + "K"
	
	#fade_in()
	
	set_process(true)
	
func _on_destroy_timer_timeout():
	queue_free()
	
