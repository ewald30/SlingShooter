extends Node2D

var health = 50
var XSpeed = 2
var YSpeed = 2
var colided = false
var exploding = false
onready var global = get_node("/root/Global")
onready var timer = get_node("Timer")
onready var particles = get_node("AnimatedSprite/Area2D/CollisionShape2D/ExplosionParticles")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(.5)


func _process(delta):
	#Called every frame
	if exploding == false:
		$AnimatedSprite.play("default")
		
		
	if global.game_paused:
		position.y += 0
	else:
		position.y += YSpeed
		position.x += XSpeed
	
	#	Executed if the collision shape exceeds the y limit of 1024
	if position.y > 1024 || position.y < -1500 || global.game_over == true:
		queue_free()
	
	#	Comment this for debugging reasons
	#	It will make the game RUN FOREVER
	if position.y > 1024 and colided == false:
		if global.game_over == false:
			get_node("/root/Game").GameOver()
	
	
	if colided == true and exploding == false:
		$AnimatedSprite.stop()
		particles.emitting = true
		#y_speed = 1
		global.score+=1
		timer.start()
		exploding = true
		$AnimatedSprite.play("dummy_animation")


func CollidedWithArea(area):
	if area.type != "projectile" :
		colided = true

func ExplodeAnimationTimeout():
	queue_free()
	timer.stop()
