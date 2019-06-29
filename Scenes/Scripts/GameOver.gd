extends CanvasLayer

func _on_TryAgainButton_pressed():
	get_tree().change_scene(Global.LEVEL_SCENE % str(Configuration.configuration.level))
	return


func _on_QuitButton_pressed():
	get_tree().quit()
