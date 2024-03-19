extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_store_button_pressed():
	%HomeUI.visible=false
	%StoreUI.visible=true


func _on_upgrade_button_pressed():
	%HomeUI.visible=false
	%UpgradesUI.visible=true


func _on_settings_button_pressed():
	%HomeUI.visible=false
	%SettingsUI.visible=true
