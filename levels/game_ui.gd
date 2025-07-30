extends Control

var score: int = 0
var combo_count: int = 0



func _ready():
	Signals.IncrementScore.connect(IncrementScore)
	Signals.IncrementCombo.connect(IncrementCombo)
	Signals.ResetCombo.connect(ResetCombo)
	
func IncrementScore(incr: int):
	score += incr
	%ScoreLabel.text = str(score) + " pts"
	
func IncrementCombo():
	print("i")
	combo_count += 1
	%ComboLabel.text = "Combo: " + str(combo_count) + "x"
	
func ResetCombo():
	print("f")
	combo_count = 0
	%ComboLabel.text = "Combo: " + str(combo_count) + "x"
	
