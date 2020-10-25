extends Node2D


var reloaded = true
var shooting = false
var event_position = Vector2(0,0)

onready var timer = get_node("Timer")
onready var global = get_node("/root/Global")

func move(target):
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self,"position",position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()
	
var choices = [preload("res://Scenes/ProjectileType1.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(global.reloading_time)

func _process(delta):
	if Input.is_action_just_released("click"):
		shooting = false
	if shooting == true and reloaded == true:
			
		#	Create a projectile of type 1 (as shown below),
		#		create an instance of that projectile (a physical thing)
		#		add_child() ?????
		#		get the node of the player emitter and use it to shoot
		
		var arrow = choices[0].instance()
		arrow.position = get_node("archer").position
		add_child(arrow)
		
		#	Wait a certain time before the next shot is taken ( wait for reloading )
		timer.start()
		reloaded = false

		#	Create a 2D Vector using the difference between x and y for playey
		#		and clicked mouse pisition
		#	Velocity - represents the rate at which x and y coordinates
		#				are modified in a time period (1 frame here)
		var velocity = Vector2(event_position.x - 256, event_position.y - 900)
		
		#	Select a speed for the velocity
		var speed = 10
		
		#	By normalizing the velocity vector we get
		#		the unit vector of velocity that holds
		#		information only about direction and
		#		not about distance
		
		arrow.YSpeed = velocity.normalized().y * speed
		arrow.XSpeed = velocity.normalized().x * speed
		print("arorw: ",arrow.position)
		# Using this, we multiply with our selected speed
		#	And we get the rate at which x and y coordinates
		#	of our projectile grows in a frame (velocity)
func _input(event):
	if global.game_paused:
		return
	#	Add a timer and a condition to shoot only after
	# 		the game starts

	#	Get the mouse button pressed event
	#		even.pressed is used becouse otherwise the engine
	#		would consider pressing and releasing 2 different events
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and global.game_started == true and event.position.y < 900:
		print("Mouse clicked at: ", event.position)
		event_position = event.position
		shooting = true



func WeaponReloaded():
	reloaded = true
