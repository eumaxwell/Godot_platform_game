extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $Camera2D as Camera2D
@onready var control = $CanvasLayer_HUD/Control

# Called when the node enters the scene tree for the first time.
func _ready():
	player.follow_camera(camera)
	player.player_has_died.connect(relaod_game)
	control.time_is_up.connect(relaod_game)
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func relaod_game():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
