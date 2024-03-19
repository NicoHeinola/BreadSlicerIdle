extends Node

var normal_upgrades: Dictionary = {
	"bread_spawn_delay": {
		"name": "Spawn Delay",
		"values": [2, 1.5, 1],
		"value_scales": [
			{
				"type": "subtract",
				"value": 0.1
			},
		],
		"max_upgrades": 13,
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

func get_normal_upgrade_cost(upgrade_name: String, cost_index: int) -> float:
	var upgrade: Dictionary = normal_upgrades[upgrade_name]
	
	var manual_cost_amount: int = len(upgrade["costs"])
	if cost_index < manual_cost_amount:
		return upgrade["costs"][cost_index]
		
	# How many times we need to loop the cost to find out what it is at the given index
	var loop_amount: int = cost_index - manual_cost_amount + 1
	
	var upgrade_cost: float = upgrade["costs"][manual_cost_amount - 1]
	for i in range(loop_amount):
		# Do each modification operation for the number
		for operation in upgrade["cost_scales"]:
			upgrade_cost = number_modify_handler(upgrade_cost, operation)
	
	return upgrade_cost

func get_normal_upgrade_value(upgrade_name: String, value_index: int) -> float:
	var upgrade: Dictionary = normal_upgrades[upgrade_name]
	
	var manual_value_amount: int = len(upgrade["values"])
	if value_index < manual_value_amount:
		return upgrade["values"][value_index]
		
	# How many times we need to loop the cost to find out what it is at the given index
	var loop_amount: int = value_index - manual_value_amount
	
	var upgrade_value: float = upgrade["values"][manual_value_amount - 1]
	for i in range(loop_amount):
		# Do each modification operation for the number
		for operation in upgrade["value_scales"]:
			upgrade_value = number_modify_handler(upgrade_value, operation)
	
	return upgrade_value

func number_modify_handler(number: float, operation: Dictionary) -> float:
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
