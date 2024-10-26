extends MarginContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Musica.play_music(preload("res://Audio/demo1.mp3"))  # Música del menú.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jugar_pressed() -> void:
	print("jaja")
	$"../AnimationPlayer".play("FADE_IN")
	
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/menu/Creditos.tscn")

func _on_salir_pressed() -> void:
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Inicio/Intro.tscn")
