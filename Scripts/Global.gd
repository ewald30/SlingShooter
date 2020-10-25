extends Node2D

var test_var = "hello"

#	For testing purposes leave it to 0.1, change it later to 1
var reloading_time = 0.2
var score = 0
var enemy_speed = 5
var emit_time = 2
var emit_min = .5
var emit_delta = .005
var game_paused = false
var speedrun = false
var game_over = false
var game_started = false

var money = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
