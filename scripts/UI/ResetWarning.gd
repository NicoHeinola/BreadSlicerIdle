extends CanvasLayer

signal back_button_pressed



func _on_cancel_pressed():
	self.visible=false
	back_button_pressed.emit()
