extends CharacterBody2D

# Constantes para velocidade de movimento e pulo
const SPEED = 200.0  # Velocidade de movimento horizontal
const JUMP_VELOCITY = 200.0  # Força do pulo

# Referências para o sprite animado e o HUD para pontuação
@onready var sprite: AnimatedSprite2D = $sprite
@onready var hud = $"../Hud/Label"

# Variáveis para gravidade e pontuação
var gravity = 980  # Força de gravidade aplicada ao personagem
var pontuacao: int = 0  # Pontuação do jogador

# Função que controla a física do personagem
func _physics_process(delta):
	# Aplica gravidade quando o personagem está no ar
	if not is_on_floor():
		velocity.y += gravity * delta

	# Pula se o botão de ação for pressionado e o personagem estiver no chão
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Define a velocidade horizontal do personagem
	velocity.x = SPEED

	# Troca de animação com base no estado do personagem
	if is_on_floor():  # No chão
		if Input.is_action_just_pressed("ui_accept"):
			sprite.play("jump")  # Animação de pulo
		else:
			sprite.play("walk")  # Animação de caminhada
	elif velocity.y > 0:  # Caindo
		sprite.play("fall")
	else:  # Subindo no pulo
		sprite.play("jump")
	
	# Move o personagem e ajusta com colisões
	move_and_slide()

# Função para coletar moeda e atualizar pontuação
func coletaMoeda():
	pontuacao += 1  # Incrementa a pontuação
	hud.text = "pontuação: %d" % pontuacao  # Atualiza o HUD com a nova pontuação
