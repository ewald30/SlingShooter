extends Node2D

var health = 1000
var x_speed = 2
var colided = false
var exploding = false
var moving = false
var animation_done = false

#	A flag used for directoin can be set to left / right 
var direction = "left"

#	Tells if the boss is in the position of the attack 
var ready = false
var reloaded = true

#	Variables for particles
onready var explosion_particles = get_node("ExplodingParticles")
onready var blood_particles = get_node("BloodParticles")

onready var global = get_node("/root/Global")
onready var boss_emitter = get_node("/root/Game/BossFIghtEmitters")

#	Timers used for different things
onready var timer = get_node("Timer")
onready var shooting_timer = get_node("ShootingTimer")
onready var boss_beaten_timer = get_node("BossBeaten")
onready var dead_animation_timer = get_node("DeadAnimationTimer")

var projectile = preload("res://Scenes/FloatingEyeProjectile.tscn")

func _ready():
	timer.set_wait_time(5)
	shooting_timer.set_wait_time(0.5)
	boss_beaten_timer.set_wait_time(10)
	dead_animation_timer.set_wait_time(4)

	

func CollidedWithArea(area):
	blood_particles.emitting = true
	health -= area.damage
	if health == 0:
		BossIsBeaten()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if global.game_over == true:
		queue_free()
		
		
	#	If the boss is beaten stop the animation
	if exploding == true and animation_done == false:
		$FloatingEye.play("dead")
	elif animation_done == true:
		$FloatingEye.play("dummy")
	
	#	Check if the boss is too high and move it accordingly
	if position.y < 300 :
		position.y += 3
	else:
		if ready == false:
			moving = true
			ready = true
	
	#	If the boss is not moving and is not exploding
	#		play the idle animation
	if moving == false && exploding == false:
		$FloatingEye.play("idle")
		position.x += 0
	elif exploding == false:
		#	Check the directoin and move to a certain position
		if direction  == "left":
			$FloatingEye.play("left")
			position.x -= 3
			if reloaded == true:
				#	If you can shoot a projectile then start reloading
				boss_emitter.shoot(self.position)
				shooting_timer.start()
				reloaded = false
			
		else:
			$FloatingEye.play("right")
			position.x += 3
			if reloaded == true:
				boss_emitter.shoot(self.position)
				shooting_timer.start()
				reloaded = false
		#	If we reach the left/right limit stop and idle for some seconds
		if position.x > 150  || position.x < -140:
			moving = false
			timer.start()
			
	

# Check the position and move accordingly
#	left / right
# 	Get a posiiton flag

func BossIsBeaten():
	#	Called if the boss health is 0
	#		- emit the particles
	#		- stop the animation
	#		- set a timer for queue free after the particles have emitted

	$FloatingEye.play("dummy")
	explosion_particles.emitting = true
	boss_beaten_timer.start()
	exploding = true
	dead_animation_timer.start()

func TimerTimeout():
	print(position.x)
	if position.x < -140:
		direction  = "right"
	elif position.x > 150:
		direction = "left"
	moving = true


func DoneReloading():
	reloaded = true

func QueueFreeTimeout():
	#	After the exploding particles are emitted, destroy the boss
	queue_free()


func DeadAnimationTimeout():
	animation_done = true
