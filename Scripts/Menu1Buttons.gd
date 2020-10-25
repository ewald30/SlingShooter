extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func UpgradePressed():
	get_node("MainMenuNode").move(Vector2(-576,0))
	get_node("UpgradeMenuNode").move(Vector2(0,0))



func BackPressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	get_node("UpgradeMenuNode").move(Vector2(576,0))
	get_node("DifficultyMenuNode").move(Vector2(576,0))


func StartPressed():
	 get_node("MainMenuNode").move(Vector2(576,0))



func BackFromStartPressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	if global.speedrun == true:
		global.emit_time = 3
		global.enemy_speed = 5
		global.speedrun = false






func DifficultyPressed():
	get_node("MainMenuNode").move(Vector2(-576,0))
	get_node("DifficultyMenuNode").move(Vector2(0,0))


func EasyPressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	get_node("UpgradeMenuNode").move(Vector2(576,0))
	get_node("DifficultyMenuNode").move(Vector2(576,0))
	global.emit_time = 3
	global.enemy_speed = 5

func MediumPressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	get_node("UpgradeMenuNode").move(Vector2(576,0))
	get_node("DifficultyMenuNode").move(Vector2(576,0)) # Replace with function body.
	global.emit_time = 1.5
	global.enemy_speed = 7

func HardPressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	get_node("UpgradeMenuNode").move(Vector2(576,0))
	get_node("DifficultyMenuNode").move(Vector2(576,0))
	global.emit_time = 1.5
	global.enemy_speed = 10
	global.reloading_time = 0.1

func ImpossiblePressed():
	get_node("MainMenuNode").move(Vector2(0,0))
	get_node("UpgradeMenuNode").move(Vector2(576,0))
	get_node("DifficultyMenuNode").move(Vector2(576,0))
	global.emit_time = 0.7
	global.enemy_speed = 15
	global.reloading_time = 0


func SpeedrunPressed():
	ImpossiblePressed()
	get_node("/root/Game").StartPressed()
	get_node("/root/Game/Background").StartPressed()
	global.speedrun = true



