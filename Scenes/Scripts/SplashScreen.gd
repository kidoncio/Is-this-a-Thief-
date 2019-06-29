extends CanvasLayer

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")


func _on_TutorialButton_pressed() -> void:
	get_tree().change_scene(Global.TUTORIAL_SCENE)


func _on_QuitButton_pressed():
	get_tree().quit()