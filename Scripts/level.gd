extends Node2D

const ITEM_SCENE = preload("res://cenas/item.tscn")  # Substitua pelo caminho correto do seu item

func _ready():
	var spawn_timer = $Timer
	spawn_timer.wait_time = 3.0  # Tempo entre aparições
	spawn_timer.start()

func _on_Timer_timeout():
	var item_instance = ITEM_SCENE.instance()
	add_child(item_instance)
