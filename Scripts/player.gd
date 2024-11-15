extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = 200.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var hud = $"../Hud/Label"

var gravity = 980
var pontuacao: int = 0

func _physics_process(delta:):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	velocity.x = SPEED
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			sprite.play("jump")
		else:
			sprite.play("walk")
	elif velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("jump")
		
	move_and_slide()
func coletaMoeda():
	pontuacao += 1
	hud.text = "pontuação: %d" % pontuacao
