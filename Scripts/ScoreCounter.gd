extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if global.game_over == false:
		bbcode_text = ""
		self.append_bbcode("[center]"+str(global.score)+"[/center]")
	else:
		bbcode_text = ""
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
