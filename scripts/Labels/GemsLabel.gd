extends Label


func _process(delta):
	self.text = str(Global.gems)


func _on_gem_button_pressed():
	Global.gems += 1
