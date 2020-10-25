extends Node2D

onready var global = get_node("/root/Global")
onready var timer = get_node("Timer")

#	A flag which represents the animation that has to play based
#		on a cposition x
#		The flag can be:
#			- idle - idle animation
#			- right - player turns to right
#			- left	- player turns to left
var turned_left_right = "idle"


# Called when the node enters the scene tree for the first time.
func _ready():
	#	By defaul the animation "idle" is playing
	$Character.play("idle")
	timer.set_wait_time(0.3)


func move(target):
	var move_tween = get_node("bkd_tween")
	move_tween.interpolate_property(self,"position",position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()


func _process(delta):
	#	Play the animation in each frame based on the flag
	$Character.play(turned_left_right)

func _input(event):
	
	# We calculate in which direction the player has to turn
	#	Based on the coordinate of x
	# Then set the flag accordingly
	if event is InputEventMouseButton and event.pressed == false and global.game_started == true:
		if event.position.x > 300:
			print(event.position.x)
			turned_left_right = "right"
			timer.start()
		elif event.position.x < 160:
			turned_left_right = "left"
			timer.start()
		else:
			turned_left_right = "idle"


#func DoneReloading():
#	#	The timer is over => the gun is reloading
#	reloaded = true




func TimerTimeout():
	#	When the animation left/right stops after a given amount of time
	#		( see function _ready() )
	#	We reset the animation back to the idle one
	turned_left_right = "idle"
