extends Node

var upgrades: Dictionary = {
	"bread_spawn_delay": {
		"name": "Spawn Delay",
		"type": "normal",
		"static_value": -1,
		"static_value_index": -1,
		"values": [2, 1.5, 1],
		"value_scales": [
			{
				"type": "subtract",
				"value": 0.1
			},
		],
		"max_upgrades": 13,
		"static_cost": -1,
		"static_cost_index": -1,
		"costs": [10, 20, 25, 50, 100],
		"cost_scales": [
			{
				"type": "multiply",
				"value": 1.05
			},
			{
				"type": "add",
				"value": 100
			}
		]
	}
}

func _ready() -> void:
	for upgrade in GlobalStats.bought_upgrades:
		var value: float = GlobalStats.bought_upgrades[upgrade]
		set_next_upgrade_index(upgrade, value)

func can_afford_upgrade(upgrade_name: String, money: int) -> bool:
	return money >= upgrades[upgrade_name]["static_cost"]

func update_next_upgrade_index(upgrade_name: String):
	var index = upgrades[upgrade_name]["static_cost_index"] + 1
	set_next_upgrade_index(upgrade_name, index)
	
func set_next_upgrade_index(upgrade_name: String, index: int):
	var upgrade: Dictionary = upgrades[upgrade_name]
	
	var new_value = calculate_value_at(upgrade["static_value_index"], index, upgrade["values"], upgrade["value_scales"], upgrade["static_value"])
	upgrades[upgrade_name]["static_value"] = new_value
	upgrades[upgrade_name]["static_value_index"] = index

	var new_cost = calculate_value_at(upgrade["static_cost_index"], index, upgrade["costs"], upgrade["cost_scales"], upgrade["static_cost"])
	upgrades[upgrade_name]["static_cost_index"] = index
	upgrades[upgrade_name]["static_cost"] = new_cost

func calculate_value_at(start_index: int, end_index: int, values: Array, operations: Array, value_at_start_index: float = 0) -> float:
	var manual_values_amount: int = len(values)
	if end_index < manual_values_amount:
		return values[end_index]
		
	if(start_index <= manual_values_amount):
		value_at_start_index = values[manual_values_amount - 1]
		start_index = manual_values_amount - 1

		
	# How many times we need to loop the cost to find out what it is at the given index
	var loop_amount: int = end_index - start_index

	for i in range(loop_amount):
		# Do each modification operation for the number
		for operation in operations:
			value_at_start_index = number_operation_handler(value_at_start_index, operation)
	
	return value_at_start_index

func number_operation_handler(number: float, operation: Dictionary) -> float:
	if operation["type"] == "add":
		return number + operation["value"]
	elif operation["type"] == "subtract":
		return number - operation["value"]
	elif operation["type"] == "multiply":
		return number * operation["value"]
	elif operation["type"] == "divide":
		return number / operation["value"]
	
	print("Invalid operation: ", operation["type"])
	return number
