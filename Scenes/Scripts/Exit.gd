extends ColorRect

func _on_Area2D_body_entered(body):
	if body.has_node(Global.SUITCASE_NODE):
		get_tree().change_scene(Global.VICTORY_SCENE)
