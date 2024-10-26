extends RigidBody3D

func _ready():
	# Configura la velocidad inicial de la bala
	linear_velocity = Vector3(0, 0, 0)

func _process(delta):
	# Aquí puedes agregar cualquier lógica adicional que desees para la bala
	if position.y < -10:  # Destruir la bala si se cae
		queue_free()  # Elimina la bala si está por debajo del límite
