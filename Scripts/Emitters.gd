extends Node2D

var timer
onready var mob_timer = get_node("MobTimer")

var enemy_speed = 5
onready var global = get_node("/root/Global")
var emitters = [get_node("emt1"), get_node("emt2"), get_node("emt3"), get_node("emt4"), get_node("emt5"), get_node("emt6")]

#	IF current mob nb < max mob nb => add another mob to randomize from
var max_mob_number = 4
var current_mob_number = 1

# 		Preaload more choices for enemys
var choices = [preload("res://Scenes/Enemy1_Meteorite.tscn")
,preload("res://Scenes/Enemy2_MeteoriteFlame.tscn"),
preload("res://Scenes/Enemy3_SkullFlameMob.tscn"),
preload("res://Scenes/Enemy4_GreenSlime.tscn")]


# Called when the node enters the scene tree for the first time.
func _ready():
	mob_timer.set_wait_time(10)
	current_mob_number = 1

func move(target):
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self,"position",position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func beginGame(state):
	# State = false => continue game
	# State = true => stop the game
	current_mob_number = 1
	enemy_speed = 5
	if state == false:
		timer = get_node("Timer")
		timer.set_wait_time(global.emit_time)
		mob_timer.start()
		timer.start()

func TimerTimeout():
	if global.game_paused:
		return
		
	randomize()
	
	#	Create an enemy based on the time passed since the beginning of the game
	#		Create an instance of that and add it as a child to enemyEmitters node
	
	var enemy = choices[int(rand_range(current_mob_number-1,current_mob_number))].instance()
	add_child(enemy)
	
	#     Pick a random emitter 
	#		Get position from that emitter and drop the enemy
	randomize()
	var emit = int(rand_range(1,7))
	if emit == 1:
		enemy.position = get_node("emt1").position
	if emit == 2:
		enemy.position = get_node("emt2").position
	if emit == 3:
		enemy.position = get_node("emt3").position
	if emit == 4:
		enemy.position = get_node("emt4").position
	if emit == 5:
		enemy.position = get_node("emt5").position
	if emit == 6:
		enemy.position = get_node("emt6").position
	
	#	Based on the time passed since the game started, the enemy speed is different
	#		
	enemy.y_speed += int(enemy_speed)
	
	#	If the game is not over, start the countdown to create another enemy
	if (global.game_over == false):
		timer.set_wait_time(global.emit_time)
		timer.start()
	else:
		timer.stop()
		
		


func AddAnotherMobTimerTimeout():
	#	If the set time has passed since our last timer timeout
	#	Increase the speed of the enemy to make it more difficult
	
	enemy_speed += 1
	
	#	Go to the next type of mob if possible
	#		And start the timer again
	if current_mob_number < max_mob_number:
		current_mob_number += 1
		mob_timer.start()
