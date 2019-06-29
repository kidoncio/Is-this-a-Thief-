extends Node2D

var text

const MESSAGE_TRANSITION_ANIMATION: String = "MessageTransition"

func _ready():
	add_to_group(Global.INTERFACE_GROUP)
	
	text = get_json()
	update_pointer_position(0, false)
	$TutorialGUI/Popup.show()


func get_json():
	var file = File.new()
	file.open(Global.TUTORIAL_MESSAGES_JSON, file.READ)
	
	var content = file.get_as_text()
	file.close()
	
	return parse_json(content)


func update_pointer_position(number: int, play_sfx: bool = true) -> void:
	var pointer = $ObjectivePointer
	
	if $ObjectiveMarkers.get_child_count() == 0:
		return
	
	var marker = $ObjectiveMarkers.get_child(number)
	
	$Tween.interpolate_property(pointer, "position", pointer.position, marker.position, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$TutorialGUI/Popup/Label.text = text[str(number)]
	
	if play_sfx && pointer.position != marker.position:
		$TutorialGUI/AnimationPlayer.play(MESSAGE_TRANSITION_ANIMATION)
		play_sfx()

func play_sfx() -> void:
	$AudioStreamPlayer.play()


func _on_ObjectiveMove_body_entered(body):
	update_pointer_position(1)


func _on_ObjectiveDoor_body_entered(body):
	update_pointer_position(2)


func _on_ObjectiveNightVision_body_entered(body):
	update_pointer_position(4)


func _on_Suitcase_body_entered(body):
	update_pointer_position(3)


func NightVision_mode() -> void:
	$GUI.visible = false
	$TutorialGUI/Popup.hide()


func DarkVision_mode() -> void:
	$GUI.visible = true
	$TutorialGUI/Popup.show()