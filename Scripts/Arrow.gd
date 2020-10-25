extends Node2D

onready var global = Global
var YSpeed = 0
var XSpeed = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (global.game_over == true):
		queue_free()
	if global.game_paused:
		position.y += 0
		position.x += 0
	else:
		position.y += YSpeed
		position.x += XSpeed



func CollidedWithArea(area):
	queue_free()
