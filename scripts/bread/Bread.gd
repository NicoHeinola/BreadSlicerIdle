extends Node2D
class_name Bread

@onready var body_left: RigidBody2D = $"BodyLeft"
@onready var body_right: RigidBody2D = $"BodyRight"

@onready var collider_left: CollisionShape2D = $"BodyLeft/Collider"
@onready var collider_right: CollisionShape2D = $"BodyRight/Collider"

@onready var image_left_node: Sprite2D = $"BodyLeft/Image"
@onready var image_right_node: Sprite2D = $"BodyRight/Image"

@onready var despawn_timer: Timer = $"DespawnTimer"

var active_texture_index: int = 0
var slice_start_pos: Vector2 = Vector2.ZERO
var is_slicing: bool = false
var sliced: bool = false

@onready var tween: Tween = get_tree().create_tween()

signal sliced_bread_signal


func get_selected_texture_data() -> Dictionary:
	return BreadDatas.textures[active_texture_index]

func set_texture(texture: Texture2D) -> void:
	image_left_node.texture = texture
	image_right_node.texture = texture

	image_left_node.region_enabled = true
	image_right_node.region_enabled = true
	
	var scale: float = min((get_viewport_rect().size.x * 0.85) / texture.get_width(), 1)
	image_left_node.scale = Vector2(scale, scale)
	image_right_node.scale = Vector2(scale, scale)

	image_left_node.region_rect = Rect2(0, 0, texture.get_width() / 2, texture.get_height())
	image_right_node.region_rect = Rect2(
		texture.get_width() / 2, 0, texture.get_width() / 2, texture.get_height()
	)

func reset_bread() -> void:
	var texture = self.get_selected_texture_data()["texture"]
	var screen_center = get_viewport_rect().size / 2
	self.position = Vector2(screen_center.x, screen_center.y)

	body_left.gravity_scale = 0
	body_right.gravity_scale = 0
	
	body_left.set_position(Vector2(-image_left_node.get_rect().size.x * image_left_node.scale.x / 2, 0))
	body_right.set_position(Vector2(image_left_node.get_rect().size.x * image_left_node.scale.x / 2, 0))

	image_left_node.set_position(Vector2(0, -get_viewport_rect().size.y))
	image_right_node.set_position(Vector2(0, -get_viewport_rect().size.y))

	var tween_duration: float = 0.5
	tween.set_parallel(true)
	tween.tween_property(image_left_node, "position", Vector2(image_left_node.position.x, 0), tween_duration)
	tween.tween_property(image_right_node, "position", Vector2(image_right_node.position.x, 0), tween_duration)

func _ready() -> void:
	self.set_texture(get_selected_texture_data()["texture"])
	self.reset_bread()


func start_slicing(position: Vector2) -> void:
	self.is_slicing = true
	self.slice_start_pos = position


func end_slicing(position: Vector2) -> void:
	if self.sliced or not self.is_slicing:
		return

	var y_difference = abs(position.y - slice_start_pos.y)
	var allowed_offset = 100
	var texture_height = get_selected_texture_data()["texture"].get_height()

	if y_difference < (texture_height - allowed_offset) * image_left_node.scale.x:
		return

	self.is_slicing = false

	sliced_bread()


func sliced_bread() -> void:
	tween.stop()
	
	self.sliced = true
	GlobalStats.money += get_selected_texture_data()["base_money"]

	body_left.gravity_scale = 1
	body_right.gravity_scale = 1

	body_left.apply_torque(-100000)
	body_right.apply_torque(100000)

	body_left.apply_force(Vector2(-10000, 0))
	body_right.apply_force(Vector2(10000, 0))

	self.despawn_timer.start()
	self.sliced_bread_signal.emit()


func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_slicing(event.position)
			else:
				self.is_slicing = false
	elif event is InputEventMouseMotion:
		end_slicing(event.position)


func _on_despawn_timer_timeout():
	self.queue_free()
