extends Area2D

func _on_Suitcase_body_entered(body):
	Global.Player.collect_suitcase()
	queue_free()
