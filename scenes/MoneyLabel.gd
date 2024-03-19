extends Label


func _process(delta):
	self.text = str(Global.money)


func _on_button_pressed():
	Global.money += 1
