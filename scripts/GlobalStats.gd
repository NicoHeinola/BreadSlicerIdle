extends Node

signal money_changed(new_value: int, old_value: int)
signal bought_upgrade(upgrade_name: String, new_value: int, old_value: int)

var money: int :
	get:
		return money
	set(value):
		money_changed.emit(value, money)
		money = value
	
var gems: int = 0

var ascension_points: int = 0
var super_ascension_points: int = 0

# Upgrades

var bought_upgrades = {
	"bread_spawn_delay": 0,
}

func buy_upgrade(upgrade_name: String, amount: int = 1) -> void:

	var old_value = bought_upgrades[upgrade_name]	
	
	for i in range(amount):
		if not UpgradeDatas.can_afford_upgrade(upgrade_name, money):
			return
			
		money -= UpgradeDatas.upgrades[upgrade_name]["static_cost"]
			
		bought_upgrades[upgrade_name] += amount
		UpgradeDatas.update_next_upgrade_index(upgrade_name)

	bought_upgrade.emit(upgrade_name, bought_upgrades[upgrade_name], old_value)
