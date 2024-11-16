extends CharacterBody2D

# Constantes para velocidade de movimento e pulo
const SPEED = 200.0  # Velocidade de movimento horizontal
const JUMP_VELOCITY = 400.0  # Força do pulo

# Referências para o sprite animado e o HUD para pontuação
@onready var sprite: AnimatedSprite2D = $sprite
@onready var hud = $"../Hud/Label"

# Variáveis para gravidade, pontuação e controle de pulo
var gravity = 980  # Força de gravidade aplicada ao personagem
var pontuacao: int = 0  # Pontuação do jogador
var can_double_jump = false  # Controle para permitir pulo duplo

# Função que controla a física do personagem
func _physics_process(delta):
	# Aplica gravidade quando o personagem está no ar
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimento lateral
	velocity.x = 0  # Reseta o movimento horizontal
	if Input.is_action_pressed("ui_right"):  # Movimenta para a direita
		velocity.x += SPEED
		sprite.flip_h = true  # Garante que o sprite está voltado para a direita
	elif Input.is_action_pressed("ui_left"):  # Movimenta para a esquerda
		velocity.x -= SPEED
		sprite.flip_h = true  # Garante que o sprite está voltado para a esquerda

	# Controle de pulo e pulo duplo
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():  # Pulo inicial
			velocity.y = -JUMP_VELOCITY
			can_double_jump = true  # Ativa a possibilidade de pulo duplo
		elif can_double_jump:  # Pulo duplo
			velocity.y = -JUMP_VELOCITY
			can_double_jump = false  # Desativa o pulo duplo

	# Troca de animação com base no estado do personagem
	if is_on_floor():  # No chão
		sprite.play("walk")  # Sempre toca a animação de caminhada no chão
	else:  # No ar (subindo ou caindo)
		sprite.play("jump")  # Sempre toca a animação de pulo no ar

	# Move o personagem e ajusta com colisões
	move_and_slide()

# Função para coletar moeda e atualizar pontuação
func coletaMoeda():
	pontuacao += 1  # Incrementa a pontuação
	hud.text = "Pontuação: %d" % pontuacao  # Atualiza o HUD com a nova pontuação
