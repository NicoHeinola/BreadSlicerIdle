extends Node2D
class_name Bread

var bread_textures: Array = [
	{
		"texture": preload("res://graphics/breads/bread-1.png"),
	}
]

@onready var image_left_node: Sprite2D = $"ImageLeft"
@onready var image_right_node: Sprite2D = $"ImageRight"

func set_texture(texture: Texture2D) -> void:
	image_left_node.texture = texture
	image_right_node.texture = texture
	
func _ready() -> void:
	set_texture(bread_textures[0]["texture"])

