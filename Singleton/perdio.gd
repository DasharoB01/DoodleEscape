extends Node

signal perdio
signal off
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func murio():
	emit_signal("perdio")

func apagar():
	emit_signal('off')
