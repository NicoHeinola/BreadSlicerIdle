extends Node2D


@onready var bread_scene: PackedScene = preload("res://scenes/bread/Bread.tscn")
@onready var bread_spawn_timer = $"BreadSpawnTimer"

func _ready() -> void:
	self.start_bread_spawn_timer()

	GlobalStats.connect("bought_upgrade", on_bought_upgrade)
	
func on_bought_upgrade(upgrade_name: String, new_value: int, old_value: int) -> void:
	match upgrade_name:
		"bread_spawn_delay":
			bread_spawn_timer.wait_time = UpgradeDatas.upgrades[upgrade_name]["static_value"]
	
	print(bread_spawn_timer.wait_time, upgrade_name)

func start_bread_spawn_timer() -> void:
	bread_spawn_timer.start()

func create_bread() -> void:
	var bread: Bread = self.bread_scene.instantiate()
	
	bread.connect("sliced_bread_signal", self.start_bread_spawn_timer)
	
	self.add_child(bread)
