extends CharacterBody3D

var velocidad = 1.5  # Velocidad del NPC
var direccion = Vector3(1, 0, 0)  # Dirección inicial (derecha)

var limite_izquierdo = -5.0
var limite_derecho = 5.0

var tiempo_disparo = 0.0
var intervalo_disparo = 5.0  # Disparar cada 5 segundos

# Carga la escena de la bala (Rigidbody3D)
var bullet_scene = preload("res://Design/sprite3d/Bullet.tscn")  # Cambia esto a la ruta correcta
var jugador 
var vivo = true
func _ready() -> void:
	Perdio.connect("perdio", Callable(self, "condiosito"))
	
func condiosito():
	vivo = false

func TakeDamage(value: int, empuje_direccion: Vector3) -> void:
	$AudioStreamPlayer3D.playing = true
	queue_free()

func _process(_delta):  # Nota: '_delta' es ahora con guión bajo
	# Movimiento de izquierda a derecha
	if vivo:
		if get_parent():
			jugador = null
			var buscar = get_parent().get_children()
			for i in buscar:
				if i.name == "PlayerCombate":
					jugador = i
		if jugador:
			if position.x > limite_derecho:
				direccion = Vector3(-1, 0, 0)  # Cambia de dirección a la izquierda
				$enemy.flip_h = true  # Gira el sprite para mirar a la izquierda
			elif position.x < limite_izquierdo:
				direccion = Vector3(1, 0, 0)  # Cambia de dirección a la derecha
				$enemy.flip_h = false  # Gira el sprite para mirar a la derecha

			# Mover al NPC
			velocity.x = direccion.x * velocidad
			move_and_slide()  # Mueve el cuerpo basado en la velocidad

			# Animación de caminar
			if velocity.x != 0:  # Si el NPC se está moviendo
				if !$enemy.is_playing() or $enemy.animation != "run":
					$enemy.play("run")  # Reproduce la animación de caminar
			
			# Manejar el disparo
			tiempo_disparo += _delta  # Usar '_delta' para aumentar el tiempo de disparo
			if tiempo_disparo >= intervalo_disparo:
				disparar()
				tiempo_disparo = 0.0

func disparar():
	# Crear la bala (Rigidbody3D) y asignar su posición
	var bullet = bullet_scene.instantiate()  # Obtiene la instancia de la escena de la bala
	bullet.position = position + Vector3(direccion.x, 0, 0)  # Posición frente al NPC
	bullet.linear_velocity = direccion * 2  # Ajusta la velocidad de la bala
	get_parent().add_child(bullet)  # Agrega la bala al nodo padre
	$enemy.play("shot")  # Reproduce la animación de disparo
