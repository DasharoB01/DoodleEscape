extends Node3D

var indexImage = 0
var diseñoMapa = [",","res://Design/Sprites/icon.svg","res://Design/Sprites/2D/Poster/Movie.jpg","res://Design/Sprites/2D/Poster/Oeste.jpg"] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Mapa.connect("mapa", Callable(self, "actualizarIndex"))
	Mapa.emitir()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.x
func _process(delta: float) -> void:
	pass

func actualizarIndex(index):
	$Libro_V1/Sprite3D.texture = load(diseñoMapa[index])
