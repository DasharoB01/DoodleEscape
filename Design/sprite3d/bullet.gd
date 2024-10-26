extends RigidBody3D

var health 
var tiempo_de_vida = 3.0  # Tiempo en segundos antes de que la bala se destruya


func _ready():
	$Timer.start()

func damage():
	return 10  # El daño que inflige el enemigo


func _on_timer_timeout() -> void:
	queue_free()
