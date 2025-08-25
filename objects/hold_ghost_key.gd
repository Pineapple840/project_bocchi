extends Sprite2D

func Setup(key_name: String, ghost_pos: Vector2):
	position = ghost_pos
	
	match key_name:
		'button_D':
			$KeyIndicator.text = "[center]" + "D"
		'button_F':
			$KeyIndicator.text = "[center]" + "F"
		'button_J':
			$KeyIndicator.text = "[center]" + "J"
		'button_K':
			$KeyIndicator.text = "[center]" + "K"
