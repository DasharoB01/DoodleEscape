extends CharacterBody3D

@export var speed := 0.1
@export var label : Label3D
var jugador_Combate = preload("res://Scenes/Characters/Player/player_combate.tscn")
var cambiarEscena = false

func RecibirPosicion(lugar):
	position.y = lugar
	
# ESCENA DE PELEA PUTA DEL PENDEJO PUTO IDIOTA DEL BRANDON 
# PERO NO SIRVE POR QUE EL BRANDON ES UN PUTO BASTARDO

#	if event.is_action_pressed("Interactuar"):
#		var instancia = jugador_Combate.instantiate()
#		instancia.position.y = position.y
#		instancia.position.x = position.x
#		instancia.rotation = rotation
#		get_parent().add_child(instancia)
#		queue_free()


# MOVIMIENTO PERSONAJE
##############################################################################
func _physics_process(delta: float) -> void:
	var direction = Vector3()
	if Input.is_action_pressed("w"):
		direction.y += 1
	if Input.is_action_pressed("s"):
		direction.y -= 1
	if Input.is_action_pressed("a"):
		direction.z += 1
	if Input.is_action_pressed("d"):
		direction.z -= 1

	direction = direction.normalized() * 2 * delta
	
	move_and_collide(direction)
##############################################################################


# CAMBIO ESCENA
##############################################################################
func _on_area_3d_body_entered(body: Node3D) -> void:  
	cambiarEscena = true
	label.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void: 
	cambiarEscena = false
	label.visible = false

func _input(event: InputEvent) -> void:
	if (cambiarEscena == true):
		if event.is_action_pressed("Interactuar"):
			Mapa.locationIndex()
			Mapa.aguardar(position.y)
		
			# Cambiar escena
			get_tree().change_scene_to_file("res://Scenes/Map/Cuarto2.tscn")
	
##############################################################################
