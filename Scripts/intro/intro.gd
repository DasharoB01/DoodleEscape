extends VideoStreamPlayer

var iniciar = false

func _ready() -> void:
	$ColorRect/AnimationPlayer.play("fade_out")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if iniciar:
		paused = false

func _on_timer_timeout() -> void:
	iniciar = true


func _on_finished() -> void:
	get_tree().change_scene_to_file("res://pruebas/pruebaSubir.tscn")
