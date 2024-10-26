extends CharacterBody2D  # El nodo principal del personaje

# Señales (coméntalas si no las usas por ahora)
# signal cambioEscema
# signal mapa

# Variables
var bullet_speed = 300
var can_shoot = true
var shoot_cooldown = 1.0  # Tiempo entre disparos
var last_shot_time = 0
var player = null

# Referencias a nodos
@onready var animated_sprite = $AnimatedSprite2D  # Para manejar las animaciones del personaje
@onready var bullet_animation = $AnimatedSprite2D.get_animation("bala")  # Asumimos que la animación de la bala está en el mismo AnimatedSprite

# Función _ready
func _ready():
	animated_sprite.play("static")
	# Encuentra al jugador en la escena
	player = get_node("/root/Path/To/Player")  # Cambia la ruta al nodo del jugador

# Función _process con el parámetro "_delta" para evitar la advertencia
func _process(_delta):
	# Si puede disparar y se presiona el botón de disparo
	if player and can_shoot and Input.is_action_just_pressed("ui_select"):
		shoot_bullet()
		animated_sprite.play("disparo")
		can_shoot = false
		last_shot_time = Time.get_ticks_msec() / 1000.0

	# Control del cooldown de disparo
	if (Time.get_ticks_msec() / 1000.0 - last_shot_time) > shoot_cooldown:
		can_shoot = true
		animated_sprite.play("static")

# Función para disparar la animación de la bala
func shoot_bullet():
	if player:
		# Reproduce la animación de la bala
		animated_sprite.play("bala")
		
		# Calcular la dirección hacia el jugador
		var direction = (player.position - position).normalized()
		
		# Mover la bala en esa dirección (simulado con la animación)
		move_bullet(direction)

# Función para simular el movimiento de la bala en una dirección
func move_bullet(direction: Vector2):
	var bullet_position = position
	bullet_position += direction * bullet_speed * get_process_delta_time()
	position = bullet_position  # Mueve el personaje en dirección recta hacia el jugador
