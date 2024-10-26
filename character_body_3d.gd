extends CharacterBody3D

# Variables para la detección del jugador y comportamiento del NPC
var player = null
var velocidad = 5.0
var rango_detecion = 20.0
var rango_ataque = 2.0
var direccion = Vector3.LEFT
var atacando = false

# Referencias a los nodos de animación y colisión
@onready var animated_sprite = $AnimatedSprite3D

func _ready():
	# Buscar al jugador (asumiendo que el nodo jugador tiene el nombre "Player")
	player = get_node_or_null("/root/Node3D/Player")

func _physics_process(delta):
	if player:
		var distancia = global_transform.origin.distance_to(player.global_transform.origin)
		
		# Si el jugador está dentro del rango de detección
		if distancia <= rango_detecion:
			# Cambiar de dirección hacia el jugador
			direccion = (player.global_transform.origin - global_transform.origin).normalized()
			
			# Si el jugador está lo suficientemente cerca, atacar
			if distancia <= rango_ataque:
				atacar()
			else:
				mover_y_correr(delta)
		else:
			# Si el jugador no está cerca, moverse de izquierda a derecha
			patrullar(delta)
	else:
		# Si no hay jugador, seguir patrullando
		patrullar(delta)

func patrullar(delta):
	# Alternar dirección si llega a los bordes
	if is_on_wall():
		direccion = -direccion
	
	# Movimiento básico de izquierda a derecha
	velocity.x = direccion.x * velocidad
	move_and_slide()  # Mover al NPC
	animated_sprite.play("run")  # Animación de correr

func mover_y_correr(delta):
	# Movimiento hacia el jugador
	velocity.x = direccion.x * velocidad
	move_and_slide()  # Mover al NPC
	animated_sprite.play("run")  # Animación de correr

func atacar():
	# Cambiar a animación de ataque
	if not atacando:
		atacando = true
		animated_sprite.play("attack")
		
		# Esperar un momento para permitir que la animación de ataque se ejecute
		await get_tree().create_timer(1.0).timeout
		atacando = false
