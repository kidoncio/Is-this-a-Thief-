extends "res://Scenes/Scripts/Character.gd"

var motion: Vector2 = Vector2()

func _process(delta):
	update_motion(delta)
	move_and_slide(motion)


func update_motion(delta: float) -> void:
	pass
