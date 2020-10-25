extends Node2D


export (int) var health

onready var global = Global
var YSpeed = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += YSpeed
	


func CollidedWithArea(area):
	#if get_node("Area2D").areaType == area.Type:
	queue_free()
		
