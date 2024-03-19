extends Label

func _ready():
	GlobalStats.connect("money_changed", self.update_money)
	self.update_money(GlobalStats.money, 0)

func update_money(new_money: int, old_money: int):
	self.text = "Money: \n" + str(new_money)
