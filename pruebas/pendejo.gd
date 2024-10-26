extends CharacterBody3D

@export var velocidad: float = randf_range(0.75, 2.5)
@export var jugador: CharacterBody3D  # Referencia al jugador
@export var health := 100.0
@export var gravedad: float = -9.81  # Valor de gravedad

var muerto = false
var atacando = false

# Variable para almacenar la velocidad vertical
var velocidad_vertical: float = 0.0
var vivo = true
func _ready() -> void:
	$Sprite3D.play("Atacar")
	Perdio.connect("perdio", Callable(self, "condiosito"))
	
func condiosito():
	vivo = false

func _process(delta: float):
	if vivo:
		if get_parent():
			jugador = null
			var buscar = get_parent().get_children()
			for i in buscar:
				if i.name == "PlayerCombate":
					jugador = i
		$Sprite3D2/SubViewport/ProgressBar.value = health
		if not $Sprite3D.is_playing():
			atacando = false
		if health <= 0 and not muerto:
			muerto = true
			$Sprite3D.stop()
			$Sprite3D.play("Muerto")
		elif health >= 1:	
			if not atacando:
				# Aquí no necesitas usar get_node, solo usa jugador directamente
				if jugador:
					var direccion = jugador.global_transform.origin - global_transform.origin
					direccion.y = 0
					
					if direccion.length() > 0.1:
						direccion = direccion.normalized() * velocidad * delta
						if direccion.x > 0:
							$Sprite3D.flip_h = true
						else:
							$Sprite3D.flip_h = false
						$Sprite3D.play("Caminar")
						move_and_collide(direccion)
				else: 
					$Sprite3D.play("Caminar")
			# Aplicar gravedad
			velocidad_vertical += gravedad * delta  # Aumentar la velocidad vertical por la gravedad
			move_and_collide(Vector3(0, velocidad_vertical * delta, 0))  # Mover en la dirección vertical
	else:
		$Sprite3D.play('Caminar')
func TakeDamage(value: int, empuje_direccion: Vector3) -> void:
	health -= value
	$AudioStreamPlayer3D.playing = true
	# Aplicar el empuje en la dirección dada
	velocity.x = empuje_direccion.x * 1.65  # Ajusta la fuerza del empuje si es necesario
	
	# Usar move_and_slide o move_and_collide para aplicar el empuje
	move_and_collide(Vector3(velocity.x, 0, 0))
	
	# Opcional: iniciar un temporizador para detener el empuje después de un tiempo
	$TimerEmpuje.start()

# Temporizador para finalizar el empuje
func _on_timer_empuje_timeout() -> void:
	velocity.x = 0  # Restablecer la velocidad después del empuje

func damage():
	if not muerto:
		atacando = true
		$Sprite3D.play("Atacar")
		return 10  # El daño que inflige el enemigo

func _on_sprite_3d_animation_finished() -> void:
	if muerto:
		queue_free()
