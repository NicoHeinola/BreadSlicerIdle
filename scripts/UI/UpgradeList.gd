extends ScrollContainer
class_name UpgradeList

@onready var upgradable_item_scene: PackedScene = load("res://scenes/UI/UpgradableItem.tscn")
@onready var item_list: VBoxContainer = $ItemList

var upgrade_type: String = "normal"
var upgrade_item_map: Dictionary = {}

func _ready():
	GlobalStats.connect("bought_upgrade", on_bought_upgrade)
	GlobalStats.connect("stats_reset", reload_upgrades)
	
	reload_upgrades()
	
func reload_upgrades() -> void:
	for upgrade_key in upgrade_item_map:
		var child = upgrade_item_map[upgrade_key]
		item_list.remove_child(child)
	
	for upgrade_name in UpgradeDatas.upgrades:
		var upgrade: Dictionary = UpgradeDatas.upgrades[upgrade_name]
		if upgrade["type"] != upgrade_type:
			continue
		
		var new_item: UpgradableItem = upgradable_item_scene.instantiate()
		upgrade_item_map[upgrade_name] = new_item
	
		item_list.add_child(new_item)
		
		new_item.upgrade_name = upgrade_name		
		new_item.update_text()


func on_bought_upgrade(upgrade_name: String, new_value: int, old_value: int) -> void:
	if upgrade_name not in upgrade_item_map:
		return
		
	upgrade_item_map[upgrade_name].update_text()
