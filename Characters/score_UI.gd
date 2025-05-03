extends RichTextLabel

func _process(delta: float) -> void:
	self.text = "Score: " + str(Global.score)

# apparently i have to create this seperate script in order for the score to increment and i dont know why
