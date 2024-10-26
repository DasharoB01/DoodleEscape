extends CharacterBody2D

# Variables configurables
var personaje: CharacterBody2D  # Usamos CharacterBody2D para el personaje
var velocidad = 200
var distancia_seguridad = 100
var en_pelusa = true  # Control para detener la animación de pelusa una vez que no quede

# Función para mover el NPC alejándose del personaje
func _physics_process(delta):
	# Asegúrate de tener una referencia válida al personaje
	if personaje:
		var distancia = position.distance_to(personaje.position)
	
		if distancia < distancia_seguridad:
			# Calcular dirección opuesta al personaje
			var direccion = (position - personaje.position).normalized()
			velocity = direccion * velocidad
			move_and_slide()
		else:
			# Si está fuera del rango de seguridad, detener movimiento
			velocity = Vector2.ZERO
			move_and_slide()

# Función para aplicar daño y soltar pelusa
func recibir_danio():
	if en_pelusa:
		# Reproducir un solo frame de la animación Explosion
		var animated_sprite = $AnimatedSprite2D
		animated_sprite.play("Explosion")
		animated_sprite.frame = 0  # Solo el primer frame de la animación

		# Aquí puedes controlar la lógica de cuándo dejar de soltar pelusa
		if should_stop_pelusa():
			en_pelusa = false

# Función para determinar si la pelusa se debería acabar
func should_stop_pelusa() -> bool:
	# Lógica para definir cuándo parar de soltar pelusa
	# Esto es solo un ejemplo, puedes ajustarlo a tu necesidad.
	return false  # Cambia a true cuando se haya soltado suficiente pelusa
 
