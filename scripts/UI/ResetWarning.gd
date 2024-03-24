extends CanvasLayer

signal back_button_pressed()
signal yes_button_pressed()


func _on_cancel_pressed():
	self.visible = false
	back_button_pressed.emit()


func _on_yes_pressed():
	self.visible = false
	yes_button_pressed.emit()
