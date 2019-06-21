extends Area2D

var can_click: bool = false
var combination = []

export var lock_group: String = "UNSET"
export var combination_length: int = 4

onready var _combination_generator = get_tree().get_root().find_node("CombinationGenerator", true, false)

signal combination

# Signals
const COMBINATION_SIGNAL: String = "combination"

func _ready():
	get_combination()
	$Label.rect_rotation = - rotation_degrees
	$Label.text = lock_group


func get_combination() -> void:
	combination = _combination_generator.generate_combination(combination_length)
	set_popup_text()
	
	emit_signal(COMBINATION_SIGNAL, combination, lock_group)


func set_popup_text() -> void:
	$CanvasLayer/ComputerPopup.set_text(combination)


func _on_Computer_body_entered(body):
	can_click = true
	$Light2D.enabled = true


func _on_Computer_body_exited(body):
	can_click = false
	$Light2D.enabled = false
	$CanvasLayer/ComputerPopup.hide()


func _input_event(viewport, event, shape_idx):
	if can_click && Input.is_mouse_button_pressed(BUTTON_LEFT):
		$CanvasLayer/ComputerPopup.popup_centered()