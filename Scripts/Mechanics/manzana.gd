extends RigidBody3D

var agarrar = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


@warning_ignore("unused_parameter")
func _on_area_3d_body_entered(body: Node3D) -> void:
	agarrar = true


@warning_ignore("unused_parameter")
func _on_area_3d_body_exited(body: Node3D) -> void:
	agarrar = false
	
@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Interactuar") and agarrar:
		queue_free()
