extends ColorRect



func _on_Area2D_body_entered(body):
	if body.has_node(Global.SUITCASE_NODE):
		print("You have a suitcase")
