extends Area2D

# Configurações do item
const SPEED = 200  # Velocidade de movimento do item (unidades por segundo)
const START_X = 1350  # Posição inicial no eixo X (fora da tela)
const END_X = -100  # Posição onde o item desaparece
const MIN_Y = 300  # Posição mínima no eixo Y (limite inferior da movimentação)
const MAX_Y = 650  # Posição máxima no eixo Y (limite superior da movimentação)

# Referências aos nós filhos
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

# Temporizador para respawn
@onready var timer = Timer.new()

func _ready():
	# Configura posição inicial com altura aleatória
	position = Vector2(START_X, randf_range(MIN_Y, MAX_Y))

	# Configura o temporizador
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_respawn"))
	add_child(timer)  # Adiciona o temporizador ao nó atual

func _process(delta):
	# Move o item para a esquerda
	position.x -= SPEED * delta

	# Verifica se o item saiu da tela
	if position.x < END_X:
		desaparece()

func _on_body_entered(body: Node):
	# Verifica se colidiu com o jogador
	if sprite.visible and body.name == "Player":  # Só coleta se o item estiver visível
		body.coletaMoeda()  # Chama a função do jogador para adicionar pontos
		desaparece()

func desaparece():
	# Desativa o movimento, sprite, colisão e o próprio Area2D
	set_process(false)
	sprite.visible = false
	collision.disabled = true
	monitoring = false  # Desativa o monitoramento de colisões

	# Define o tempo de reaparecimento aleatório (5, 10 ou 15 segundos)
	timer.wait_time = randi_range(5, 15)
	timer.start()

func _respawn():
	# Reposiciona o item na posição inicial com altura aleatória
	position = Vector2(START_X, randf_range(MIN_Y, MAX_Y))

	# Reativa o sprite, colisão, movimento e monitoramento de colisões
	sprite.visible = true
	collision.disabled = false
	monitoring = true  # Reativa o monitoramento de colisões
	set_process(true)
