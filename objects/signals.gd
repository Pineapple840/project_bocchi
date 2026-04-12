extends Node2D

signal LoadMenu(menu: String)


signal GetNoteOffset()

signal ChangeCurrentSong(song_name: String)
signal ChangeCurrentMod(mod_name: String)


signal IncrementScore(incr: int)
signal IncrementCombo()
signal ResetCombo()
signal SetTimingLabel(val: float)


signal CreateFallingKey(button_name: String, x_pos: float, y_pos: float, is_multi_note: bool, is_hold_note: bool, ghost_pos: Vector2)
signal KillGhost(button_name: String)

signal TransmitSongInfo(jump_distance: float)

signal LevelStart(video_start_time: float, seconds_per_beat: float, offset: float, jump_distance: float)

signal PlayVideo(video_resource: String, video_start_time: float)
signal PlayVideoConnected()
signal VideoStarted()

signal SendVideoDesync(difference: float)

signal ChangeBocchiBlobFace(face: String)

signal SongEnded()
signal TransmitScoreData(score: String, accuracy: String)
