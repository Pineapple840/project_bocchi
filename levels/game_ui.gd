extends Control

var score: int = 0
var combo_count: int = 0
var total_note_val: int = 0
var total_notes: int = 0
var accuracy: int = 0



func _ready():
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	
func IncrementScore(incr: int):
	score += incr * combo_count
	%ScoreLabel.text = str(score) + " pts"
	
	match incr:
		300:
			total_note_val += 100
		100:
			total_note_val += 60
		50: 
			total_note_val += 30
		0:
			total_note_val += 0
	
	total_notes += 1
	accuracy = total_note_val / total_notes
	%AccuracyLabel.text = "Accuracy " + str(accuracy) + "%"
	
	
func IncrementCombo():
	combo_count += 1
	%ComboLabel.text = str(combo_count) + "x"
	
	if combo_count >= 5:
		Signals.ChangeBocchiBlobFace.emit("happy")
		
	
func ResetCombo():
	combo_count = 0
	%ComboLabel.text = str(combo_count) + "x"
	
	Signals.ChangeBocchiBlobFace.emit("sad")
	
