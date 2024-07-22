extends Control

@onready var life_counter = $MarginContainer/Life_contaiiner/Life_counter as Label
@onready var timer_counter = $MarginContainer/Timer_contaiiner/Timer_counter as Label
@onready var score_counter = $MarginContainer/Score_contaiiner2/Score_counter as Label
@onready var coin_counter = $MarginContainer/Coins_contaiiner/Coin_counter as Label
@onready var clock_timer = $Clock_timer as Timer

var minutes = 0
var seconds = 0
@export_range(0,5) var default_minutes := 1
@export_range(0,59) var default_seconds := 0

signal time_is_up()


func _ready():
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	reset_clock_timer()

func _process(delta):
	coin_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)
	
	if minutes == 0 && seconds == 0:
		emit_signal("time_is_up")	
	
func _on_clock_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
		
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
	
