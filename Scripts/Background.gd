extends Node2D





onready var global = get_node("/root/Global")

#func DoneReloading():


func StartPressed():
	get_node("MenuBackgroundNode").move(Vector2(576,0))
	get_node("StaredBackgroundNode").move(Vector2(576,0))



func BackPressed():
	get_node("MenuBackgroundNode").move(Vector2(0,0))
	get_node("StaredBackgroundNode").move(Vector2(0,0))


func BossFightPressed():
	get_node("MenuBackgroundNode").move(Vector2(576,0))
	get_node("BossFightBackground").move(Vector2(288,512))


func BackFromBossFight():
	get_node("MenuBackgroundNode").move(Vector2(0,0))
	get_node("BossFightBackground").move(Vector2(-288,512))
