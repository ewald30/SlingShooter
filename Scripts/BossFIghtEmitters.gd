extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global")
onready var emitters = get_node("BossEmitter")
onready var timer =  get_node("Timer")

var game_started = false
# 		Preaload more choices for enemys
var bosses = [preload("res://Scenes/FlloatingEye.tscn")]
var projectile = preload("res://Scenes/FloatingEyeProjectile.tscn")

func move(target):
	var move_tween = get_node("Tween")
	move_tween.interpolate_property(self,"position",position, target, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	move_tween.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func beginGame():
	timer = get_node("Timer")
	timer.set_wait_time(global.emit_time)
	timer.start()

func TimerTimeout():
	if global.game_started == false:
		var boss = bosses[0].instance()
		add_child(boss)
		global.game_started = true

func _process(delta):
	if global.game_paused || game_started == false:
		return

func shoot(position):
	if global.game_paused == true:
		return
	var projectile_instance = projectile.instance()
	projectile_instance.position = position
	projectile_instance.position.y += 40
	projectile_instance.YSpeed = 7
	#projectile_instance.XSpeed = 0
	add_child(projectile_instance)
	projectile_instance.global_translate(Vector2(0,0))


	
	
