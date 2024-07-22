extends RigidBody2D

func _on_area_2d_coin_tree_exited():
	queue_free()
