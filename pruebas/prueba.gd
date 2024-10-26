extends Node3D

var enemy = preload("res://Scenes/Characters/Enemy/character_body_3d.tscn")
var cofre = preload("res://Scenes/AssetsScenes/cofre.tscn")
var MaximasInstancias = 15
var InstanciasTotales = 0
var InstanciasLimites = 10
var cooldownInstancia = false
var total = []
var cambiarEscena = false
var uncofre = false
var mapaIndex = 0
@onready var label = $Pagina

@export var camera : Camera3D

@onready var timer = $Timer
@onready var fade_in = $ColorRect/AnimationPlayer

var width_visible: float
var height_visible: float

var vivo = true
var listo = false
var oscurecido = false

func _ready() -> void:
	print(fade_in)
	update_camera_size()  # Inicializa el tamaño de la cámara
	Mapa.connect("cambiarDificultadxd", Callable(self, "emitir"))
	Mapa.cambiarDificultad()
	
	Perdio.connect("off", Callable(self, 'apagando'))
	Perdio.connect("perdio", Callable(self, "condiosito"))
	
func condiosito():
	vivo = false	

func emitir(multiplicador):
	MaximasInstancias = round(multiplicador)
	print(MaximasInstancias)
	

func _process(delta: float) -> void:
	if vivo:
		total = []
		for i in get_children():
			if i is CharacterBody3D:
				if i.get_child(1).name == "enemy":
					total.append(i)
			
		if InstanciasTotales < MaximasInstancias: 
			$Area3D/CollisionShape3D.disabled = true
			if total.size() < InstanciasLimites:
				if not cooldownInstancia:
					cooldownInstancia = true
					timer.start()
					var instancia = enemy.instantiate()
					instancia.position.y = 3  # Aseguramos que Y sea 3
					# Establecer la posición aleatoria fuera de la vista
					instancia.global_position = get_random_spawn_position()
					
					InstanciasTotales += 1
					add_child(instancia)
		else:
			if total.size() > 0:
				pass
			else:
				if not uncofre:
					uncofre = true
					$AudioStreamPlayer.playing = true
					var instancia = cofre.instantiate()
					instancia.position = Vector3(2.26,1.27,.50)
					add_child(instancia)
					$Area3D/CollisionShape3D.disabled = false
	else:
		if listo and not oscurecido:
			oscurecido = true
			fade_in.play("oscurecer")
		
func apagando():
	listo = true	
# Función para actualizar y obtener el tamaño de la cámara
func update_camera_size() -> void:
	var aspect_ratio = get_viewport().size.x / get_viewport().size.y  # Proporción de aspecto
	var camera_size = camera.size  # Esto ahora es un float que representa el tamaño de la cámara
	
	# Obtener dimensiones visibles
	width_visible = camera_size * aspect_ratio  # Cambié a un float, así que no hay 'x'
	height_visible = camera_size  # La altura es igual al tamaño de la cámara

# Función para obtener una posición aleatoria fuera de la vista de la cámara
func get_random_spawn_position() -> Vector3:
	var x_offset: float
	
	# Decidimos si spawn en la izquierda o derecha
	if randf() > 0.5:
		# Spawn fuera de la izquierda
		x_offset = randf_range(-width_visible - 10, -10)  # Fuera a la izquierda
	else:
		# Spawn fuera de la derecha
		x_offset = randf_range(width_visible + 10, width_visible + 20)  # Fuera a la derecha
	
	var z_offset = 0  # Z es 0 según tu requerimiento
	return Vector3(x_offset, 3, z_offset)  # Aseguramos que Y sea 3 y Z sea 0

func _on_timer_timeout() -> void:
	cooldownInstancia = false 

func _on_area_3d_body_entered(body: Node3D) -> void:  
	print("dentro")
	cambiarEscena = true
	label.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void: 
	cambiarEscena = false
	label.visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interactuar") and cambiarEscena:
		if Mapa.mapaIndex == 2:
			get_tree().change_scene_to_file("res://Inicio/menu/MainMenuu.tscn")
		else:
			get_tree().change_scene_to_file("res://pruebas/pruebaSubir.tscn")
			Mapa.sumarmapaindex()

	if event.is_action_pressed("espacio") and not vivo:
		get_tree().change_scene_to_file("res://Inicio/menu/MainMenuu.tscn")
		Mapa.reiniciar()
