extends Label

func _ready():
	GlobalStats.connect("money_changed", _on_bread_sliced_bread_signal)

func _on_bread_sliced_bread_signal():
	self.text = "Money: " + str(GlobalStats.money)
