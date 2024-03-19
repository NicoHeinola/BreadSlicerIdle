extends Label


func _process(delta):
	self.text = str(Global.score)


func _on_button_pressed():
	Global.score += 1
