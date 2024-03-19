extends Node2D


@onready var bread_scene: PackedScene = preload("res://scenes/bread/Bread.tscn")

func _ready() -> void:
	self.create_bread()
	
func create_bread() -> void:
	var bread: Bread = self.bread_scene.instantiate()
	
	bread.connect("sliced_bread_signal", self.create_bread)
	
	self.add_child(bread)
