extends Node2D

signal IncrementScore(incr: int)

signal IncrementCombo()
signal ResetCombo()

signal CreateFallingKey(button_name: String, x_pos: float, y_pos: float, is_multi_note_bool: bool)

signal PlayVideo(video_start_time: float)
signal PlayVideoConnected()

signal ChangeBocchiBlobFace(face: String)
