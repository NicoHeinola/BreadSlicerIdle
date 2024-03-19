extends Node

signal money_changed(new_value: int, old_value: int)

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
