extends Node

var money: int :
	get:
		return money
	set(value):
		money_changed.emit()
		money = value
	
var gems: int = 0

var ascension_points: int = 0
var super_ascension_points: int = 0

signal money_changed()
