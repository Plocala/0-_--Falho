extends Area2D

# Variáveis
@export var speed := 55
@export var detection_radius := 377.0
var player
var merdas = []

# Player e Merda
func _ready():
	player = get_parent().get_node("Player")
	merdas = get_parent().get_children().filter(func(child) -> bool:
		return child.name == "Merda"
	)
	connect("body_entered", Callable(self, "_on_body_entered"))

# Movimento
func _physics_process(delta):
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player <= detection_radius:
			var direction = (player.global_position - global_position).normalized()
			global_position += direction * speed * delta
			
			# Flip
			if direction.x < 0:
				$Sprite2D.flip_h = true
			elif direction.x > 0:
				$Sprite2D.flip_h = false

	# Desviar das Merdas
	for merda in merdas:
		var distance_to_merda = global_position.distance_to(merda.global_position)
		if distance_to_merda <= detection_radius / 4:
			var direction = (merda.global_position - global_position).normalized()
			global_position -= direction * speed * delta

# Colisão
func _on_body_entered(body: Node2D):
	if body.name == "Player":
		get_tree().reload_current_scene()
	elif body.name == "Merda":
		queue_free()
