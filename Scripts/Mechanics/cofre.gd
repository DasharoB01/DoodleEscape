extends StaticBody3D

var abrir = false
var jugador
var attractor
var abierto = false
var manzana = preload("res://Scenes/AssetsScenes/manzana.tscn")
@onready var particle_system = $CPUParticles3D  # Sistema de partículas
func _ready() -> void:
	# Encontrar el nodo "PlayerCombate" después de que la escena esté lista
	jugador = get_parent().get_child(2)  # Asegúrate de que este sea el índice correcto

	if jugador:
		attractor = jugador.get_child(9)  # Asegúrate de que este sea el índice correcto para el Attractor3D
	else:
		pass
func _on_area_3d_body_entered(body: Node3D) -> void:
	abrir = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	abrir = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Interactuar") and abrir:
		if not abierto: 
			var manzanaInstancia = manzana.instantiate()
			manzanaInstancia.position = position
			manzanaInstancia.position.x += 1.2
			get_parent().add_child(manzanaInstancia)
			abierto = true
			$Sprite3D.play("default")
			$AudioStreamPlayer3D.playing = true
		
# Función para generar la explosión de partículas
func generar_particulas_explosion() -> void:
	particle_system.emitting = true  # Comenzar la emisión de partículas
	await get_tree().create_timer(0.5).timeout  # Esperar 0.5 segundos antes de detener la emisión
	particle_system.emitting = false  # Detener la emisión de partículas después de la explosión
	
	if jugador and attractor:
		# Activar el Attractor3D para atraer las partículas hacia el jugador
		attractor.transform.origin = jugador.global_transform.origin
		attractor.scale = Vector3(1, 1, 1)  # Ajustar el tamaño del atrayente si es necesario
		# Aquí podrías gestionar el efecto de atracción manipulando las partículas directamente
		await get_tree().create_timer(1.5).timeout  # Atraer las partículas por 1.5 segundos

	else:
		print("Attractor or PlayerCombate not found.")
