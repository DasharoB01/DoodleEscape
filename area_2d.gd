extends Area2D

var speed = 400
var direction = Vector2(1, 0)  # Dirección de la flecha, predeterminada hacia la derecha

func _process(delta):
	# Mover la flecha en su dirección con velocidad constante
	position += direction * speed * delta

	# Destruir la flecha si sale del área visible
	if position.x < 0 or position.x > get_viewport_rect().size.x:
		queue_free()

# Detectar colisiones con otros cuerpos
func _on_body_entered(body):
	queue_free()  # Destruye la flecha al colisionar
