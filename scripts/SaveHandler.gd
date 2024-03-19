extends Node

func _ready() -> void:
	load_game()

func save_game() -> void:
	var stats_save_file = FileAccess.open("user://stats.save", FileAccess.WRITE)
	
	var stats: Dictionary = {
		"money": GlobalStats.money,
		"gems": GlobalStats.gems,
		"ascension_points": GlobalStats.ascension_points,
		"super_ascension_points": GlobalStats.super_ascension_points,
		"bought_upgrades": GlobalStats.bought_upgrades
	}
	
	var stats_json_string = JSON.stringify(stats)
	stats_save_file.store_line(stats_json_string)
	
func load_game() -> void:
	# Check if there are stats to load
	if not FileAccess.file_exists("user://stats.save"):
		return

	var stats_save_file = FileAccess.open("user://stats.save", FileAccess.READ)
	
	while stats_save_file.get_position() < stats_save_file.get_length():
		var json_string = stats_save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var stats_data = json.get_data()
		
		GlobalStats.money = stats_data["money"]
		GlobalStats.gems = stats_data["gems"]
		GlobalStats.ascension_points = stats_data["ascension_points"]
		GlobalStats.super_ascension_points = stats_data["super_ascension_points"]
		GlobalStats.bought_upgrades = stats_data["bought_upgrades"]
		
