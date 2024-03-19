extends Node2D


@onready var bread_scene: PackedScene = preload("res://scenes/bread/Bread.tscn")
@onready var bread_spawn_timer = $"BreadSpawnTimer"

func _ready() -> void:
	self.start_bread_spawn_timer()

	for i in range(10):
		print(str(i) + ": ", UpgradeDatas.get_normal_upgrade_cost("bread_spawn_delay", i))

func start_bread_spawn_timer() -> void:
	bread_spawn_timer.start()

func create_bread() -> void:
	var bread: Bread = self.bread_scene.instantiate()
	
	bread.connect("sliced_bread_signal", self.start_bread_spawn_timer)
	
	self.add_child(bread)
