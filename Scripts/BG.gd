extends ParallaxBackground

# Velocidade do deslocamento do fundo
var scroll_speed = Vector2(-100, 0)  # Velocidade horizontal e vertical

func _process(delta):
	# Move o fundo continuamente com base na velocidade
	scroll_offset += scroll_speed * delta
