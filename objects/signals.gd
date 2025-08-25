extends Node2D

signal IncrementScore(incr: int)

signal IncrementCombo()
signal ResetCombo()

signal CreateFallingKey(button_name: String, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2)

signal PlayVideo(video_start_time: float)
signal PlayVideoConnected()
signal VideoStarted()

signal ChangeBocchiBlobFace(face: String)
