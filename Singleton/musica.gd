extends Node

@onready var audio_stream_player = AudioStreamPlayer.new()
var current_stream: AudioStream = null

func _ready() -> void:
	add_child(audio_stream_player)
	audio_stream_player.volume_db = -20  # Establecer el volumen a -20 dB.

func play_music(stream: AudioStream):
	if current_stream != stream:  # Solo cambiar si es una música diferente.
		audio_stream_player.stop()  # Detener la música actual.
		audio_stream_player.stream = stream
		audio_stream_player.play()
		current_stream = stream  # Actualizar la música actual.
