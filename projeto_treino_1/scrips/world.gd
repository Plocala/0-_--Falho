extends Node2D

var temp = 0
var fib_nums = [0, 1]  # Inicializando a sequência de Fibonacci
var next_fib_time = 1  # Tempo para o próximo inimigo ser gerado

func _process(delta):
	temp += delta  # Acumula o tempo passado

	# Verifica se o tempo acumulado atingiu o próximo termo da sequência de Fibonacci
	if temp/60 >= next_fib_time:
		create_enemy(random_position_enemy())
		update_fibonacci_sequence()
		temp = 0  # Reinicia o tempo acumulado após gerar um inimigo

func update_fibonacci_sequence():
	var next_fib = fib_nums[-1] + fib_nums[-2]  # Calcula o próximo termo da sequência
	fib_nums.append(next_fib)
	next_fib_time = next_fib  # Atualiza o tempo para o próximo inimigo

func random_position_enemy():
	randomize()
	return Vector2(randf_range(0, get_viewport().size.x), randf_range(0, get_viewport().size.y))

func create_enemy(pos: Vector2):
	randomize()
	var rand_value = randi() % 100  # Gera um valor aleatório entre 0 e 99
	var enemy_scene
	if rand_value < 62:
		enemy_scene = preload("res://cenas/Enemy_shurek.tscn") as PackedScene
	else:
		enemy_scene = preload("res://cenas/Enemy_esperma.tscn") as PackedScene

	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = pos
	enemy_instance.scale = Vector2(5, 5)
	add_child(enemy_instance)

func _ready():
	randomize()
	generate_map_merdas(randi_range(10, 20))
	randomize()
	generate_map_enemies(randi_range(10, 20))
	$AudioStreamPlayer2D.play()

func generate_map_merdas(num_objs: int):
	for i in range(num_objs):
		create_merda(random_position_merda())

func generate_map_enemies(num_objs: int):
	for i in range(num_objs):
		create_enemy(random_position_enemy())

func create_merda(pos: Vector2):
	var merda_scene = preload("res://cenas/merda.tscn") as PackedScene
	var merda_instance = merda_scene.instantiate()
	merda_instance.position = pos
	merda_instance.scale = Vector2(2, 2)
	add_child(merda_instance)

func random_position_merda():
	randomize()
	return Vector2(randf_range(0, get_viewport().size.x), randf_range(0, get_viewport().size.y))

func _on_merda_body_entered(body: Node2D):
	if body.name == "Enemy_shurek":
		body.queue_free()

func _on_enemy_shurek_body_entered(body: Node2D):
	if body.name == "Merda":
		body.queue_free()
