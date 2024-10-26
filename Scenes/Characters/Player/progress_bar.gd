extends ProgressBar

func _process(delta: float) -> void:
	if value == 100:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_10.png")
	elif value == 90:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_9.png")
	elif value == 80:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_8.png")
	elif value == 70:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_7.png")
	elif value == 60:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_6.png")
	elif value == 50:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_5.png")
	elif value == 40:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_4.png")
	elif value == 30:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_3.png")
	elif value == 20:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_2.png")
	elif value == 10:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_1.png")
	elif value == 0:
		$Sprite2D.texture = load("res://Design/Sprites/2D/Vida/drive-download-20241024T072416Z-001/Salud_0.png")
