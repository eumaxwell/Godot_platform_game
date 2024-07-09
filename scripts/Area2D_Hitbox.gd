extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		print("Player")
		body.velocity.y = body.JUMP_VELOCITY
		owner.animation_player.play("Hurt")
		print("BBB")
