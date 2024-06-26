extends AudioStreamPlayer

const level_music = preload("res://Audio/Music/3rdParty/Three Red Hearts - Pixel War 2.ogg")
@export var hit_sound : AudioStream
@onready var SFX_BUS_ID = AudioServer.get_bus_index(("SFX"))
func _play_music(music : AudioStream, volume = 0.0):
	if stream == music:
		return
	stream  = music
	volume_db = volume
	play()
	
func play_music_level(volume = 0.0):
	_play_music(level_music, volume)

# useful for transition scene
func play_FX(stream : AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.bus = "SFX"
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	fx_player.queue_free()
	
func _stop_music():
	if (stream):
		stream = null
		stop()
