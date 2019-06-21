extends Area2D

var player_can_open: bool = false
var is_open: bool = false

# Animations
const OPEN_ANIMATION: String = "open"
const CLOSE_ANIMATION: String = "close"

func _on_Door_body_entered(body):
	if body != Global.Player && !is_open:
		open()
	else:
		player_can_open = true


func open() -> void:
	if $AnimationPlayer.is_playing():
		return
	
	is_open = true
	
	$AnimationPlayer.play(OPEN_ANIMATION)


func close() -> void:
	is_open = false
	
	$AnimationPlayer.play(CLOSE_ANIMATION)


func _on_Door_body_exited(body):
	if body == Global.Player:
		player_can_open = false
	
	if is_open:
		close()


func _input_event(viewport, event, shape_idx):
	if player_can_open && Input.is_mouse_button_pressed(BUTTON_LEFT):
		open()
