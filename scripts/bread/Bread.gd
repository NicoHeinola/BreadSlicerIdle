extends HBoxContainer
class_name Bread

@onready var image_left_node: Sprite2D = $"ImageLeft"
@onready var image_right_node: Sprite2D = $"ImageRight"

var active_texture_index: int = 0
var slice_start_pos: Vector2 = Vector2.ZERO

func get_selected_texture_data() -> Dictionary:
	return BreadDatas.textures[active_texture_index]

func set_texture(texture: Texture2D) -> void:
	image_left_node.texture = texture
	image_right_node.texture = texture
	
func _ready() -> void:
	set_texture(get_selected_texture_data()["texture"])

func start_slicing(position: Vector2) -> void:
	slice_start_pos = position
	
func end_slicing(position: Vector2) -> void:
	var y_difference = position.y - slice_start_pos.y;
	var allowed_offset = 200
	var texture_height = get_selected_texture_data()["texture"].get_height()
	
	if y_difference < texture_height - allowed_offset:
		return

	sliced_bread()

func sliced_bread() -> void:
	Global.money += get_selected_texture_data()["base_money"]
	print(Global.money)

func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_slicing(event.position)
			else:
				end_slicing(event.position)
