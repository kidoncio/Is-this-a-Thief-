extends Node2D

func _ready():
	update_pointer_position(0, false)
	$TutorialGUI/Popup.show()


func update_pointer_position(number: int, play_sfx: bool = true) -> void:
	var pointer = $ObjectivePointer
	
	if $ObjectiveMarkers.get_child_count() == 0:
		return
	
	var marker = $ObjectiveMarkers.get_child(number)
	
	$Tween.interpolate_property(pointer, "position", pointer.position, marker.position, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	if play_sfx && pointer.position != marker.position:
		play_sfx()

func play_sfx() -> void:
	$AudioStreamPlayer.play()


func _on_ObjectiveMove_body_entered(body):
	update_pointer_position(1)


func _on_ObjectiveDoor_body_entered(body):
	update_pointer_position(2)


func _on_ObjectiveNightVision_body_entered(body):
	update_pointer_position(3)


func _on_Suitcase_body_entered(body):
	update_pointer_position(4)