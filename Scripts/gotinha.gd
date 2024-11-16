extends CharacterBody2D

# Configurações do inimigo
const SPEED = 200.0  # Velocidade de movimento da gotinha
const START_X = 1350  # Posição inicial no eixo X
const END_X = -100  # Posição onde o inimigo desaparece
const GROUND_Y = 630  # Posição do chão no eixo Y

# Referência ao AnimatedSprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Temporizador para reposicionar a gotinha
@onready var timer = Timer.new()

func _ready():
	# Configura posição inicial
	position = Vector2(START_X, GROUND_Y)

	# Configura o timer
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_respawn"))
	add_child(timer)  # Adiciona o timer como filho do nó atual

	# Inicia a animação "walk" sempre que o inimigo é criado
	animated_sprite.play("walk")

func _physics_process(delta):
	# Move a gotinha para a esquerda
	position.x -= SPEED * delta

	# Se a gotinha sair da tela, inicia o timer para reposição
	if position.x < END_X:
		desaparece()

func _on_body_entered(body: Node):
	# Verifica se colidiu com o Player
	if body.name == "Player":
		body.recebe_dano()  # Chama um método no Player
		
func desaparece():
	# Pausa o movimento enquanto a gotinha aguarda para reaparecer
	set_physics_process(false)

	# Define o tempo aleatório para reaparecer
	timer.wait_time = randi_range(5, 15)  # Aleatoriza entre 5 e 15 segundos
	timer.start()

func _respawn():
	# Reposiciona a gotinha na posição inicial
	position = Vector2(START_X, GROUND_Y)

	# Retoma o movimento
	set_physics_process(true)
