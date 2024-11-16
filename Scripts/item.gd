extends Area2D

# Variáveis para controle de posição e movimento do item
var speed = 200  # Velocidade do movimento do item (unidades por segundo)
var min_y = 300  # Posição mínima no eixo Y (limite inferior da movimentação)
var max_y = 650  # Posição máxima no eixo Y (limite superior da movimentação)
var start_position = Vector2(1300, 0)  # Posição inicial do item no eixo X (fora da tela) e Y aleatório
var respawn_time = 3.0  # Tempo para respawn (em segundos)

# Referência ao recurso do item (a cena do item que será instanciada)
var item_scene = preload("res://cenas/item.tscn")

# Função chamada quando a cena é inicializada
func _ready():
	# Define a posição inicial do item com um Y aleatório dentro do intervalo definido
	position = start_position
	position.y = randf_range(min_y, max_y)  # Aleatoriza a posição Y com randf_range

	# Inicia o processamento do item (movimento)
	set_process(true)

# Função chamada a cada frame, usada para mover o item
func _process(delta):
	# Move o item para a esquerda (reduz a posição X)
	position.x -= speed * delta

	# Quando o item sai da tela (posição X < -100), ele desaparece
	if position.x < -100:
		coletado()  # Chama a função para respawn ou remoção do item

# Função chamada quando o item colide com o jogador (Player)
func _on_body_entered(body:):
	if body.name == "Player":  # Verifica se o corpo que colidiu é o jogador
		body.coletaMoeda()  # Chama a função de coleta de moeda do jogador
		coletado()  # Chama a função para respawn ou remoção do item

# Função chamada quando o item é coletado ou sai da tela
func coletado():
	# Remove o item da cena
	queue_free()
	
	# Cria um timer para aguardar o respawn do item
	var timer = Timer.new()
	timer.wait_time = respawn_time  # Define o tempo de respawn
	timer.one_shot = true  # Configura o timer para rodar apenas uma vez
	timer.connect("timeout", Callable(self, "_respawn"))  # Conecta o sinal de timeout do timer com a função de respawn
	get_parent().add_child(timer)  # Adiciona o timer à cena

# Função chamada quando o timer expira, para realizar o respawn
func _respawn():
	# Instancia o novo item a partir da cena pré-carregada
	var novo_item = item_scene.instantiate()  # Método correto para instanciar no Godot 4
	get_parent().add_child(novo_item)  # Adiciona o novo item à cena

	# Define a posição inicial do novo item
	novo_item.position = start_position
	novo_item.position.y = randf_range(min_y, max_y)  # Define a posição Y aleatória dentro do intervalo
