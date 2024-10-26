extends MarginContainer


func _ready() -> void:
	Musica.play_music(preload("res://Audio/demo1.mp3"))  # Música de los créditos.

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/menu/MainMenuu.tscn")
