extends RichTextLabel

onready var global = get_node("/root/Global")
var message = "Score"


# Change this to func _process(delta)
# nu afiseaza scorul corect
func _process(delta):
	"""
		Prints the score on the screen when the game is over
			using bbcode
			
		bbcode_text = "" => resets the written text to "" then appends
							to it multiple strings
	"""
	
	
	
	if global.game_over == true:
		bbcode_text = ""
		self.append_bbcode("[center]Score[/center]")
		self.append_bbcode("\n")
		self.append_bbcode("[center]"+str(global.score)+"[/center]")


	
