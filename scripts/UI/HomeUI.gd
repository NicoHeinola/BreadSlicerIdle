extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_store_button_pressed():
	self.visible=false
	%StoreUI.visible=true
	


func _on_upgrade_button_pressed():
	self.visible=false
	%UpgradesUI.visible=true


func _on_settings_button_pressed():
	self.visible=false
	%SettingsUI.visible=true


func _on_store_ui_back_button_pressed():
	self.visible = true


func _on_upgrades_ui_back_button_pressed():
	self.visible = true


func _on_settings_ui_back_button_pressed():
	self.visible = true
