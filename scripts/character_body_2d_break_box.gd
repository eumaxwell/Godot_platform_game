extends CharacterBody2D

const box_pieces = preload("res://prefabs/rigid_body_2d_box_pieces.tscn")
const coin_instance = preload("res://prefabs/rigid_body_2d_coin_rigid.tscn")

@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var spawn_coin := $Marker2D_Spawn_coin as Marker2D
@export var pieces : PackedStringArray
@export var hitpoints := 3
var impulse := 120

func break_sprite():
	for piece in pieces.size():
		var piece_instace = box_pieces.instantiate()
		get_parent().add_child(piece_instace)
		piece_instace.get_node("Sprite2D_Texture").texture = load(pieces[piece])
		piece_instace.global_position = global_position
		piece_instace.apply_impulse(Vector2(randi_range(-impulse, impulse), randi_range(-impulse, -impulse *2)))
	queue_free()

func create_coin():
	var coin = coin_instance.instantiate()
	get_parent().call_deferred("add_child", coin)
	coin.global_position = spawn_coin.global_position
	coin.apply_impulse(Vector2(randi_range(-50, 50), -150))
