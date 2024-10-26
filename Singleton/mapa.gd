extends Node

var indexMap = 0
var punto = 10.8
var Multiplicador = 1.3
var dificultad = 2
var mapaIndex = 0
signal cambiarDificultadxd(multiplicador)
signal cambioEscema(posicion)
signal mapa(index)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func sumarmapaindex():
	mapaIndex += 1
	return mapaIndex

func reiniciar():
	mapaIndex = 0
	dificultad = 2
	return mapaIndex

func cambiarDificultad():
	dificultad *= Multiplicador
	print(dificultad)
	emit_signal("cambiarDificultadxd", dificultad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func emitir():
	emit_signal("cambioEscema", punto)
	emit_signal("mapa", indexMap)
	
func aguardar(lugar):
	punto = lugar

func locationIndex():
	if (indexMap < 3):
		indexMap += 1
	
