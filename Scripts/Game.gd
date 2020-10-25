extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func QuitPressed():
	get_tree().quit()
	


func StartPressed():
	get_node("UI").move(Vector2(576,0))
	get_node("EnemyEmitters").move(Vector2(576,-100))
	get_node("EnemyEmitters").beginGame(false)
	global.game_over = false
	global.game_started = true
	

func BackPressed():
	print("SCORE:   ", global.score-1)
	get_node("UI").move(Vector2(0,0))
	get_node("EnemyEmitters").move(Vector2(-576,-100))
	get_node("EnemyEmitters").beginGame(true)
	get_node("GameOverScreen").move(Vector2(-576,0))
	global.game_over = true
	global.score = 0
	global.game_started = false

func RestartPressed():
	BackPressed()
	StartPressed()

func GameOver():
	get_node("EnemyEmitters").move(Vector2(-576,-100))
	#get_node("EnemyEmitters").beginGame(true)
	get_node("GameOverScreen").move(Vector2(0,0))
	print("GAME OVER")
	print("gmOver: ",global.game_over)
	global.game_over = true
	global.game_started = false
	print("SCORE:   ", global.score-1)





func PausePressed():
	if global.game_paused == false:
		global.game_paused = true
	else:
		global.game_paused = false


func BossFightPressed():
	get_node("UI").move(Vector2(576,0))
	get_node("BossFIghtEmitters").move(Vector2(288,-100))
	global.game_started = false
	get_node("BossFIghtEmitters").beginGame()
	global.game_over = false



func BackFromBossFight():
	get_node("UI").move(Vector2(0,0))
	get_node("GameOverScreen").move(Vector2(-576,0))
	global.game_over = true
	global.score = 0
	global.game_started = false
