extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("colisao com moeda")
	$AnimatedSprite2D.play("Collect")
	


func _on_animated_sprite_2d_animation_finished():
	queue_free()
