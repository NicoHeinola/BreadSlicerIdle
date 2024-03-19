extends PanelContainer
class_name UpgradableItem

var upgrade_name: String :
	get:
		return upgrade_name
	set(value):
		upgrade_name = value
		update_text()

@onready var label: Label = $"MarginContainer/Label"

func update_text() -> void:
	if label == null:
		return
	
	var name: String = UpgradeDatas.upgrades[upgrade_name]["name"]
	var amount: String = str(UpgradeDatas.upgrades[upgrade_name]["static_value_index"])
	var cost: String = str(UpgradeDatas.upgrades[upgrade_name]["static_cost"])
	label.text = " (" + amount + ") " + name + ", Cost: " + cost

func buy_upgrade() -> void:
	GlobalStats.buy_upgrade(upgrade_name)
