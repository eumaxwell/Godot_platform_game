extends Area2D

const coin := 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite2D.play("Collect")
		await $CollisionShape2D.call_deferred("queue_free")
		Globals.coins += coin

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Collect":
		queue_free()
