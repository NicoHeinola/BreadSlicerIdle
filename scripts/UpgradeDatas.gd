extends Node

var normal_upgrades: Dictionary = {
	"bread_spawn_delay": {
		"name": "Spawn Delay",
		"values": [2, 1.5, 1],
		"value_scale": [
			{
				"scale_type": "subtract",
				"scale": 0.1
			},
		],
		"max_upgrades": 13,
		"cost": [10, 20, 25, 50, 100],
		"cost_scale": [
			{
				"scale_type": "multiply",
				"scale": 1.05
			},
			{
				"scale_type": "add",
				"scale": 100
			}
		]
	}
}

func get_normal_upgrade_cost(upgrade_name: String, cost_index: int) -> float:
	var upgrade: Dictionary = normal_upgrades[upgrade_name]
	
	var manual_cost_amount: int = len(upgrade["cost"])
	if cost_index < manual_cost_amount:
		return upgrade["cost"][cost_index]
		
	# How many times we need to loop the cost to find out what it is at the given index
	var loop_amount: int = cost_index - manual_cost_amount
	
	return 0
	
