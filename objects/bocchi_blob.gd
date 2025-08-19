extends Sprite2D

var del = 1
var animation: bool = false

func _ready():
	
	Signals.ChangeBocchiBlobFace.connect(ChangeBocchiBlobFace)
	var beat_counter = 0

	
	bounce(0.7013478261)
	
func bounce(delay):
	await get_tree().create_timer(delay).timeout
	print("x")
	bounce(0.3260869565)
	
	if animation:
		position.y += 5
		animation = false
	else:
		position.y -= 5
		animation = true
		
func ChangeBocchiBlobFace(face: String):
	match face:
		"sad":
			texture = load("res://art/bocchi_blob_sad.png")
		"happy":
			texture = load("res://art/bocchi_blob_happy.png")
		
			
