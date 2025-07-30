extends Control

#Pefect colour: ffff00
#great 00ff00
#ok 0000ff
#miss ff0000

func SetTextInfo(text: String):
		$ScoreLevelText.text = "[center]" + text
		
		match text:
			"300":
				$ScoreLevelText.set("theme_override_colors/default_color", Color("ffff00"))
			"100":
				$ScoreLevelText.set("theme_override_colors/default_color", Color("00ff00"))
			"50":
				$ScoreLevelText.set("theme_override_colors/default_color", Color("0000ff"))
			"X":
				$ScoreLevelText.set("theme_override_colors/default_color", Color("ff0000"))
		
