extends CharacterBody2D

# Constantes
const GOLDENRADIUS = ((1 + sqrt(5)) / 2) - 1
const MAX_SPEED = 80 * (GOLDENRADIUS + 1)

# Funções
func _process(delta):
	var viewport_rect = $Camera2D.get_viewport_rect()
	var shape = $CollisionShape2D.shape as CapsuleShape2D
	var shape_radius = shape.radius
	var shape_height = shape.height

	# Movimento do jogador
	if Input.is_action_pressed("ui_up"):
		velocity.y = max(velocity.y - MAX_SPEED / 10, -MAX_SPEED)
	else:
		velocity.y *= pow(GOLDENRADIUS, delta)
		
	if Input.is_action_pressed("ui_down"):
		velocity.y = min(velocity.y + MAX_SPEED / 10, MAX_SPEED)
	else:
		velocity.y *= pow(GOLDENRADIUS, delta)
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + MAX_SPEED / 10, MAX_SPEED)
		$Sprite2D.flip_h = false
	else:
		velocity.x *= pow(GOLDENRADIUS, delta)
		
	if Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - MAX_SPEED / 10, -MAX_SPEED)
		$Sprite2D.flip_h = true
	else:
		velocity.x *= pow(GOLDENRADIUS, delta)
		
	# Limitar a posição do jogador dentro dos limites da câmera
	var new_position = position + velocity * delta
	new_position.x = clamp(new_position.x, viewport_rect.position.x + shape_radius, viewport_rect.position.x + viewport_rect.size.x - shape_radius)
	new_position.y = clamp(new_position.y, viewport_rect.position.y + shape_radius, viewport_rect.position.y + viewport_rect.size.y - shape_radius)
	position = new_position

	move_and_slide()
