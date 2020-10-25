extends Node2D

var health = 50
var y_speed = 0
var colided = false
var exploding = false
onready var global = get_node("/root/Global")
onready var timer = get_node("Timer")
onready var particles = get_node("SkullFlameMobSprite/SkullFlameArea2d/CollisionShape2D/ExplosionParticles")


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(.5)


func _process(delta):
	#Called every frame
	if exploding == false:
		$SkullFlameMobSprite.play("idle")
	
	if global.game_paused:
		position.y += 0
	else:
		position.y += y_speed
		
	
	#	Executed if the collision shape exceeds the y limit of 1024
	if position.y > 1024 || position.y < -1500 || global.game_over == true:
		queue_free()
	
	#	Comment this for debugging reasons
	#	It will make the game RUN FOREVER
	if position.y > 1024 and colided == false:
		if global.game_over == false:
			get_node("/root/Game").GameOver()
	
	
	if colided == true and exploding == false:
		particles.emitting = true
		global.score+=1
		timer.start()
		exploding = true
		$SkullFlameMobSprite.stop()
		$SkullFlameMobSprite.play("dummy")


func CollidedWithArea(area):
	health -= area.damage
	if health == 0:
		colided = true


func ExplodeAnimationTimeout():
	queue_free()
	timer.stop()
