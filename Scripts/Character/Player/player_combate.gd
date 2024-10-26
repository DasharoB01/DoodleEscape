extends CharacterBody3D

const SPEED = 4.5
const JUMP_VELOCITY = 7.0
var right : bool = true
var myHealth = 100
var listaEnemigos = [] 
var cooldownDamage = false
var atacando = false
var atacandoCooldown = false
var muerto = false
@onready var animacion = $AnimatedSprite3D2

func _process(delta: float) -> void:
	if not listaEnemigos.is_empty():
		if not cooldownDamage:
			cooldownDamage = true
			$"RecibirDaño/RecibirDaño".start()
			for i in listaEnemigos:
				if i.has_method("damage"):
					var damage = i.damage()
					if damage:
						myHealth -= damage

	$CanvasLayer/ProgressBar.value = myHealth
	if myHealth <= 0:
		$CanvasLayer/ProgressBar.visible = false
		muerto = true
		animacion.play("muerte")
		Perdio.murio()
	
	if not animacion.is_playing():
		Perdio.apagar()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not muerto:
		# Control del movimiento solo si no está atacando
		if not atacando:
			if Input.is_action_just_pressed("jump") and is_on_floor():
				$AudioStreamPlayer3D.playing = true
				velocity.y = JUMP_VELOCITY
			var direction := Input.get_axis("a", "d")
			
			if direction:
				if is_on_floor():
					$AudioStreamPlayer3D2.playing = true
				velocity.x = direction * SPEED
				if velocity.x > 0: 
					scale.x = 0.8
				if velocity.x < 0:
					scale.x = -0.8
				animacion.play("caminar")
			else:
				animacion.stop()
				velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action("ataque"):
		if not atacandoCooldown:
			animacion.play("Golpear")
			atacandoCooldown = true
			atacando = true  # Restringir movimiento durante el ataque
			$Atacando.start()  # Temporizador para finalizar el ataque
			$AtacandoCooldown.start()
			$Area3D/CollisionShape3D2.disabled = false
			$Timer.start()  # Temporizador para restablecer la colisión del ataque
			empujeAdelante()  # Aplicar empuje hacia adelante

func empujeAdelante() -> void:
	var empuje = 2.5  # Valor de empuje, ajusta según sea necesario
	
	# Determinar la dirección del empuje según la escala del personaje
	if scale.x > 0:
		velocity.x = empuje  # Empuje hacia la derecha
	else:
		velocity.x = -empuje  # Empuje hacia la izquierda

	# Usar move_and_slide para aplicar el empuje
	move_and_slide()

		# Después de un corto tiempo, restablecer la velocidad
	$TiempoEmpuje.start()  # Temporizador para controlar el tiempo de empuje

	# Temporizador para finalizar el empuje
func _on_tiempo_empuje_timeout() -> void:
		velocity.x = 0  # Restablecer la velocidad normal

# Temporizador para finalizar el ataque
func _on_atacando_timeout() -> void:
	atacando = false  # Permitir movimiento de nuevo

# Temporizador para restablecer el cooldown de ataque
func _on_atacando_cooldown_timeout() -> void:
	atacandoCooldown = false  # Permitir volver a atacar
	
# Controlar daño al tocar enemigos y aplicar empuje a los enemigos
func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body)
	if body.has_method('TakeDamage'):
		var empuje_direccion : Vector3
		if scale.x > 0:
			empuje_direccion = Vector3(1, 0, 0)  # Empuje hacia la derecha
		else:
			empuje_direccion = Vector3(-1, 0, 0)  # Empuje hacia la izquierda
		
		body.TakeDamage(100, empuje_direccion)


# Deshabilitar el área de colisión del ataque después de que el ataque termina
func _on_timer_timeout() -> void:
	$Area3D/CollisionShape3D2.disabled = true

# Controlar cuando los enemigos entran o salen del área de daño
func _on_recibir_daño_body_entered(body: Node3D) -> void:
	var quemetoco = body.get_children()
	for i in quemetoco:
		if i.name == "enemy":
			if i.get_parent().has_method("damage"):
				listaEnemigos.append(i.get_parent())

func _on_recibir_daño_body_exited(body: Node3D) -> void:
	var quemetoco = body.get_children()
	for i in quemetoco:
		if i.name == "enemy":
			if i.get_parent().has_method("damage"):
				listaEnemigos.erase(i.get_parent())

# Restablecer el cooldown de daño después de un tiempo
func _on_recibir_daño_timeout() -> void:
	cooldownDamage = false
