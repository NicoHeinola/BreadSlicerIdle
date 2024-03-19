extends Label



func _on_bread_sliced_bread_signal():
	
	self.text = "Money: " + str(Global.money)
