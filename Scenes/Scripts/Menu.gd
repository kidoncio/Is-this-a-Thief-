extends Popup


func _ready() -> void:
	$NinePatchRect/CenterContainer/VBoxContainer/MusicToggleButton.pressed = Configuration.configuration.sound_muted


func show_menu() -> void:
	visible = true


func _on_MusicToggleButton_pressed():
	Configuration.toggle_sound_muted()


func _on_CloseMenuButton_pressed():
	visible = false


func _on_QuitButton_pressed():
	get_tree().quit()
