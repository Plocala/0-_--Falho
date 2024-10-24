extends Area2D

func _on_body_entered(body: Node2D):
	if body.name == "Player":
		get_tree().reload_current_scene()
	elif body.name == "Enemy_shurek":
		body.queue_free()
